module Crayon
  module StringBuilder
    def prepare_string(string)
      [ foreground_string,
        background_string,
        formatting_string,
        string,
        (TERMINATION_STRING if has_color?)
      ].compact.join("")
    end

    def has_color?
      @foreground || @background || @formatting.any?
    end

    def foreground_string
      handle_color(3, @foreground)
    end

    def background_string
      handle_color(4, @background)
    end

    def formatting_string
      return "" if @formatting.empty?
      @formatting.map{|format| "\e[#{FORMATS[format]}m"}.join("")
    end

    def handle_color(lead, color)
      return "" unless color
      "\e[#{lead}#{COLORS[color]}m"
    end
  end
end
