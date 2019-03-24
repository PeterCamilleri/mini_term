# coding: utf-8

# Get input from the user in raw mode. (Common Code)
module MiniTerm

  # Control values for flush.
  FLUSH_SLEEP = 0.01
  FLUSH_COUNT = 3

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

  # Flush the keyboard buffer.
  def self.flush
    result = ""

    raw do |input|
      FLUSH_COUNT.times do
        sleep(FLUSH_SLEEP)
        break unless input.has_raw_char?
        result << input.get_raw_char
      end
    end

    result
  end

end
