# coding: utf-8

# A input text mapper. (Common Code)
module MiniTerm

  # Translate raw input to mapped commands.
  class Mapper

    #Set up the keystroke mapper.
    def initialize
      @map = Hash.new {|_h, key| [:unmapped, key]}
      yield self
    end

    #Add a map entry
    def []=(indexes, value)
      indexes = [indexes] unless indexes.is_a?(Range)

      indexes.each do |index|
        process_non_terminals(index)

        if @map.has_key?(index)
          fail "Duplicate entry #{index.inspect}"
        end

        @map[index] = [value, index]
      end
    end

    #Handle the preamble characters in the command sequence.
    def process_non_terminals(index)
      seq = ""

      index.chop.chars.each do |char|
        seq << char

        if @map.has_key?(seq) && @map[seq]
          fail "Ambiguous entry #{index.inspect}"
        end

        @map[seq] = false
      end
    end

    #Get a mapped input sequence.
    def get_mapped_char
      key_seq, key_cmd = "", nil

      begin
        key_seq << yield
        key_cmd = @map[key_seq]
      end until key_cmd

      key_cmd
    end
  end

end