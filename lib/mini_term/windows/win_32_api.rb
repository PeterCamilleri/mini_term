# coding: utf-8

# Replacement support for deprecated win_32_api gem.
# With thanks to rb-readline gem from which this code comes.
module MiniTerm

  require 'fiddle'

  #The classic Win32API gem is deprecated, so we emulate it with fiddle.
  class Win32API

    DLL = {}

    TYPEMAP = {"0" => Fiddle::TYPE_VOID,
               "S" => Fiddle::TYPE_VOIDP,
               "I" => Fiddle::TYPE_LONG}

    # Taken from Fiddle::Importer
    # Note: They all map to 1. Why is this a thing?
    CALL_TYPE_TO_ABI = {:stdcall => 1,
                        :cdecl   => 1,
                        nil      => 1}

    def initialize(dllname, func, import, export = "0", calltype = :stdcall)
      @proto = import.join.tr("VPpNnLlIi", "0SSI").chomp('0').split('')

      handle = DLL[dllname] ||= Fiddle.dlopen(dllname)

      @func = Fiddle::Function.new(handle[func],
                                   TYPEMAP.values_at(*@proto),
                                   CALL_TYPE_TO_ABI[calltype])
    end

    def call(*args)
      args.each_with_index do |x, i|

        # Note: This code never uses Fiddle::Pointer objects. I think.
        if @proto[i] == "S" # && !x.is_a?(Fiddle::Pointer)
          args[i], = [x == 0 ? nil : x].pack("p").unpack("l!*")
        end

        # Note: This code seems to do nothing.
      #  if @proto[i] == "I"
      #    args[i], = [x].pack("I").unpack("i")
      #  end
      end

      # Note: Commented out some dead code.
      @func.call(*args).to_i # || 0
    end

  end
end
