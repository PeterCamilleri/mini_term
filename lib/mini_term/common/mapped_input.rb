# coding: utf-8

# Get input from the user in mapped mode. (Common Code)
module MiniTerm

  # The different keyboard maps available.
  @maps = Hash.new do |_h, key|
    fail MiniTermNoMap, "No mapping for term type #{key.inspect}."
  end

  # What terminal types are mapped?
  def self.map_types
    @maps.keys
  end

  # Add a terminal mapping.
  def self.add_map(type, &defn_block)
    @maps[type] = Mapper.new(&defn_block)
  end

  # Get a mapped character. Note: The block is for testing only.
  def self.get_mapped_char(&block)
    mapper = @maps[MiniTerm::TERM_TYPE]
    proc = block_given? ? block : Proc.new { get_raw_char }
    raw { mapper.get_mapped_char(&proc) }
  end

end
