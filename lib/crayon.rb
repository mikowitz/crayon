module Crayon
  extend self

  @@newline = true
 
  COLORS = {
    "black" => 0,
    "red" => 1,
    "green" => 2,
    "yellow" => 3,
    "blue" => 4,
    "magenta" => 5,
    "cyan" => 6,
    "white" => 7
  }

  FORMATS = {
    "bold" => 1,
    "underline" => 4
  }

  TERMINATION_STRING = "\e[0m"

  def newline?; @@newline; end
  def io; $stderr; end

  def self.print; @@newline = false; return Crayon; end

  def self.puts; @@newline = true; return Crayon; end

  def method_missing(method_name, string)
    io.print prepare_string(string, *parse_method_name(method_name))
    io.flush
  end

  def prepare_string(string, foreground=nil, background=nil, formatting=[])
    [
      prepare_foreground_color(foreground),
      prepare_background_color(background),
      prepare_formatting(*formatting),
      string,
      TERMINATION_STRING,
      (newline? ? "\n" : "")
    ].join("")
  end

  def parse_method_name(method_name)
    _name = method_name.to_s.split("_")
    if _idx = _name.index("on")
      _name.delete("on")
      _background_color = _name.delete_at(_idx)
    end
    _foreground_color = _name.find {|color| COLORS.keys.include?(color) }
    _formatting = _name.select{|format| FORMATS.keys.include?(format) }
    [_foreground_color, _background_color, _formatting]
  end

  def prepare_foreground_color(color=nil)
    handle_color(3, color)
  end

  def prepare_background_color(color=nil)
    handle_color(4, color)
  end

  def prepare_formatting(*formats)
    return "" if formats.empty?
    formats.map{|f| "\e[#{FORMATS[f]}m"}.join("")
  end

  def handle_color(lead, color=nil)
    return "" unless color
    "\e[#{lead}#{COLORS[color]}m"
  end
end
