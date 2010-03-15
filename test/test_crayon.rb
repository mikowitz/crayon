require 'helper'

include TinyTest

is { Crayon.newline? } # by default?

is {
  Crayon.print
  not Crayon.newline?
}

is {
  Crayon.puts
  Crayon.newline?
}

# Crayon.parse_method_name
does { Crayon.parse_method_name(:red) == ["red", nil, []] }
does { Crayon.parse_method_name(:on_red) == [nil, "red", []] }
does { Crayon.parse_method_name(:bold) == [nil, nil, ["bold"]] }

does { Crayon.parse_method_name(:blue_on_green) == ["blue", "green", []] }
does { Crayon.parse_method_name(:bold_cyan_on_magenta) == ["cyan", "magenta", ["bold"]] }

does { Crayon.parse_method_name(:red_green) == ["red", nil, []] }
does { Crayon.parse_method_name(:red_bold_underline) == ["red", nil, ["bold", "underline"]] }
does { Crayon.parse_method_name(:underline_on_green_bold) == [nil, "green", ["underline", "bold"]] }
