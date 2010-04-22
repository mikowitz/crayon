# @private
class CrayonString < String
  include Crayon

  # @private
  def method_missing(method_name, string)
    nullify_variables
    @method_name = method_name
    parse_method_name
    CrayonString.new(self + prepare_string(string))
  end
end
