# coding: utf-8

# Get input from the user in mapped mode. (Common Code)
module MiniTerm

  # The different keyboard maps available.
  @maps = Hash.new {|_h, k| fail "No mapping for term type #{k.inspect}."}

  # What terminal types are mapped?
  def self.map_types
    @map.keys
  end

  # Add a terminal mapping.
  def self.add_map(type, &defn_block)
    @maps[type] = Mapper.new(&defn_block)
  end

  def self.get_mapped_key(&block)
    mapper = @maps[MiniTerm::TERM_TYPE]
    proc = block_given? ? block : Proc.new { get_raw_char }
    mapper.get_mapped_char(&proc)
  end

end
