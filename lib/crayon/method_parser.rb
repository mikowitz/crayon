module Crayon
  # @private
  module MethodParser
    ##
    # Converts a method name into color and formatting parameters
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
  end
end
