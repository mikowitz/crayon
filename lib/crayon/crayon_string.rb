class CrayonString < String
  include Crayon

  def method_missing(method_name, string)
    nullify_variables
    @method_name = method_name
    parse_method_name
    self + CrayonString.new(prepare_string(string))
  end
end
