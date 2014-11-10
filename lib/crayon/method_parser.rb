module Crayon
  module MethodParser
    def parse_method_name
      @method_name = @method_name.to_s.downcase.split("_")
      @background = parse_background
      @foreground = parse_foreground
      @formatting = parse_formatting
    end

    def parse_background
      _idx = @method_name.index("on")
      return nil unless _idx
      @method_name.delete("on")
      _background = @method_name.delete_at(_idx)
      _background if COLORS.keys.include?(_background)
    end

    def parse_foreground
      @method_name.find {|color| COLORS.keys.include?(color) }
    end

    def parse_formatting
      @method_name.select {|format| FORMATS.keys.include?(format) }
    end
  end
end
