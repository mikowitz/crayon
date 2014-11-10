class CrayonString < String
  include Crayon

  def method_missing(method_name, string)
    @method_name = method_name
    parse_method_name
    CrayonString.new(self + prepare_string(string))
  end
end
