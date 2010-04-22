module Crayon
  module StringBuilder
    ##
    # Builds output string with color escape characters.
    # @private
    def prepare_string(string)
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
  end
end
