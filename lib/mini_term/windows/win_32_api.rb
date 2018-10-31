# coding: utf-8

# Replacement support for deprecated win_32_api gem.
# With thanks to rb-readline gem from where this code originates.
module MiniTerm

  require 'fiddle'

  #The classic Win32API gem is deprecated, so we emulate it with fiddle.
  class Win32API
    DLL   = {}
    TYPES = {"0" => Fiddle::TYPE_VOID,
             "S" => Fiddle::TYPE_VOIDP,
             "I" => Fiddle::TYPE_LONG}

    def initialize(dll_name, func, import, export = "0", _ct = nil)
      @proto = import.join.tr("VPpNnLlIi", "0SSI").chomp('0').split('')
      handle = DLL[dll_name] ||= Fiddle.dlopen(dll_name)
      @func = Fiddle::Function.new(handle[func], TYPES.values_at(*@proto), 1)
    end

    def call(*args)
      args.each_with_index do |x, i|
        if @proto[i] == "S"
          args[i] = [x == 0 ? nil : x].pack("p").unpack("l!*")[0]
        end
      end

      @func.call(*args).to_i
    end

  end
end
