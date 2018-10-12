# coding: utf-8

# Replacement support for deprecated win_32_api gem.
# With thanks to rb-readline gem from which this code comes.
class MiniTerm

  require 'fiddle'

  #The classic Win32API gem is deprecated, so we emulate it with fiddle.
  class Win32API

    DLL = {}
    TYPEMAP = {"0" => Fiddle::TYPE_VOID, "S" => Fiddle::TYPE_VOIDP, "I" => Fiddle::TYPE_LONG}
    CALL_TYPE_TO_ABI = {:stdcall => 1, :cdecl => 1, nil => 1} #Taken from Fiddle::Importer

    def initialize(dllname, func, import, export = "0", calltype = :stdcall)
      @proto = import.join.tr("VPpNnLlIi", "0SSI").chomp('0').split('')
      handle = DLL[dllname] ||= Fiddle.dlopen(dllname)
      @func = Fiddle::Function.new(handle[func],
                                   TYPEMAP.values_at(*@proto),
                                   CALL_TYPE_TO_ABI[calltype])
    end

    def call(*args)
      args.each_with_index do |x, i|
        args[i], = [x == 0 ? nil : x].pack("p").unpack("l!*") if @proto[i] == "S" && !x.is_a?(Fiddle::Pointer)
        args[i], = [x].pack("I").unpack("i") if @proto[i] == "I"
      end

      @func.call(*args).to_i || 0
    end

  end
end
