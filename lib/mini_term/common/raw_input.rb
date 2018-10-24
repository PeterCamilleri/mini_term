# coding: utf-8

# Get input from the user in raw mode. (Common Code)
module MiniTerm

  # Is input raw or cooked?
  @raw_input = false

  # Is raw mode in effect?
  def self.raw?
    @raw_input
  end

  # Execute the block with input in raw mode.
  def self.raw
    begin_raw_input unless (already_raw = raw?)
    yield(self)
  ensure
    end_raw_input unless already_raw
  end

end
