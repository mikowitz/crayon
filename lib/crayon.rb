require "crayon/method_parser"
require "crayon/string_builder"

module Crayon
  include Crayon::MethodParser
  include Crayon::StringBuilder
  extend self

  class << self
    attr_accessor :foreground, :background, :formatting, :method_name, :color
  end

  COLORS = { "black" => 0, "red" => 1, "green" => 2, "yellow" => 3, "blue" => 4, "magenta" => 5, "cyan" => 6, "white" => 7 }
  FORMATS = { "bold" => 1, "underline" => 4 }
  TERMINATION_STRING = "\e[0m"

  def method_missing(method_name, string)
    @method_name = method_name
    parse_method_name
    CrayonString.new(prepare_string(string) || "")
  end
end

require "crayon/crayon_string"
