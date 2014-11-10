class CrayonString < String
  include Crayon

  def clear(string)
    CrayonString.new(self + string)
  end

  def method_missing(method_name, string)
    @method_name = method_name
    parse_method_name
    CrayonString.new(self + prepare_string(string))
  end
end
