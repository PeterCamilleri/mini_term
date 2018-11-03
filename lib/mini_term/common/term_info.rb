# coding: utf-8

# Common Terminal Info. (Common Code)
module MiniTerm

  @options   = {}
  @term_open = false

  def self.open(options = {})
    @term_open = true
    @options = options
    validate_options
  end

  def self.close
    end_raw_input if raw?
    @term_open = false
  end

  # Is the mini_term open just now?
  def self.term_open?
    @term_open
  end

  # Make sure that mini_term is closed on exit.
  at_exit do
    if MiniTerm.term_open?
      MiniTerm.close
      puts "Force MiniTerm.close" unless @options[:quiet]
    end
  end

  # What is the terminal width in characters?
  def self.width
    term_info[1]
  end

  # What is the terminal height in rows?
  def self.height
    term_info[0]
  end

private

  def self.validate_options
    bad = @options.keys.reject { |key| VALID_OPTIONS.include?(key) }
    return if bad.empty?

    msg = "MiniTerm.open, Invalid options ignored: #{bad.join(", ")}"

    fail MiniTermStrict, msg if @options[:strict]

    puts msg unless @options[:quiet]
  end

end
