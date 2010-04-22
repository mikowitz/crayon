$:.unshift File.dirname(__FILE__) + "/crayon"

%w{ method_parser string_builder}.each {|file| require file }

module Crayon
  include Crayon::MethodParser
  include Crayon::StringBuilder
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

  # @private
  def nullify_variables
    @foreground, @background, @formatting = nil, nil, []
    @method_name, @color = nil, nil
  end
end
