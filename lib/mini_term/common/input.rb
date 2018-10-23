# coding: utf-8

# Get input from the user in raw mode.
module MiniTerm

  # Execute the block with input in raw mode.
  def self.raw
    begin_raw_input
    yield(self)
  ensure
    end_raw_input
  end

end
