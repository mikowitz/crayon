module Crayon
  extend self

  class << self
    # @private
    attr_accessor :foreground, :background, :formatting, :method_name, :color
  end

  # @private
  COLORS = { "black" => 0, "red" => 1, "green" => 2, "yellow" => 3, "blue" => 4, "magenta" => 5, "cyan" => 6, "white" => 7 }
  # @private
  FORMATS = { "bold" => 1, "underline" => 4 }
  # @private
  TERMINATION_STRING = "\e[0m"

  def self.print
    Kernel::puts "Color.print is deprecated and will be removed in version 1.1.0."
    return Crayon
  end

  def self.puts
    Kernel::puts "Color.puts is deprecated and will be removed in version 1.1.0."
    return Crayon
  end

  def method_missing(method_name, string)
    @method_name = method_name
    parse_method_name
    prepare_string(string)
    nullify_variables
    Crayon
  end

  ##
  # Converts a method name into color and formatting parameters
  # @example
  #   Crayon.parse_method_name(:bold_red_on_green)  #=>  "['red', 'green', ['bold']]"
  # @private
  def parse_method_name
    @method_name = @method_name.to_s.downcase.split("_")
    @background = parse_background
    @foreground = parse_foreground
    @formatting = parse_formatting
  end

  # @private
  def parse_background
    _idx = @method_name.index("on")
    return nil unless _idx
    @method_name.delete("on")
    _background = @method_name.delete_at(_idx)
    _background if COLORS.keys.include?(_background)
  end

  # @private
  def parse_foreground
    @method_name.find {|color| COLORS.keys.include?(color) }
  end

  # @private
  def parse_formatting
    @method_name.select {|format| FORMATS.keys.include?(format) }
  end

  ##
  # Builds output string with color escape characters.
  # @example
  #   Crayon.prepare_string('hello', 'red', 'blue', ['underline'])  #=>  "\e[31m\e[44m\e[4mhello\e[0m"
  # @private
  def prepare_string(string) #, foreground=nil, background=nil, formatting=[])
    [ prepare_foreground_color,
      prepare_background_color,
      prepare_formatting,
      string,
      (TERMINATION_STRING if @foreground || @background || !@formatting.empty?)
    ].join("")
  end

  # @private
  def prepare_foreground_color
    @color = @foreground
    handle_color(3)
  end

  # @private
  def prepare_background_color
    @color = @background
    handle_color(4)
  end

  # @private
  def prepare_formatting
    return "" if @formatting.empty?
    @formatting.map{|format| "\e[#{FORMATS[format]}m"}.join("")
  end

  # @private
  def handle_color(lead)
    return "" unless @color
    "\e[#{lead}#{COLORS[@color]}m"
  end

  # @private
  def nullify_variables
    @foreground, @background, @formatting = nil, nil, []
    @method_name, @color = nil, nil
  end
end
