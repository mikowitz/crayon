module Crayon
  module MethodParser
    def parse_method_name
      @method_name_components = @method_name.to_s.downcase.split("_")
      @background = parse_background
      @foreground = parse_foreground
      @formatting = parse_formatting
    end

    def parse_background
      on_index = @method_name_components.index("on")
      return nil unless on_index
      background = @method_name_components.delete_at(on_index + 1)
      background if COLORS.include?(background)
    end

    def parse_foreground
      @method_name_components.find {|color| COLORS.include?(color) }
    end

    def parse_formatting
      @method_name_components.select {|format| FORMATS.include?(format) }
    end
  end
end
