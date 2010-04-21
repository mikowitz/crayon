### 1.0.1 : 04/21/10

* Adds deprecation warnings for `puts` and `print`

### 1.0.0 : 04/21/10

* Fixed bug where a method name which has `on_` followed by anything not an allowed color would return an underlined string.
* Set `method_missing` to return `Crayon` so color methods can be chained.
* Crayon can handle mixed-case method names.

### 0.0.5 : 04/21/10

* Moved functionality from passing variables between methods to using instance variables.

### 0.0.4 : 04/21/10

* Adds documentation and hides most helper methods from public documentation.

### 0.0.3 : 04/21/10

* Switches documentation from RDoc to Markdown
* Moves gem dependencies into Gemfile
* Switches tests over to RSpec


### 0.0.2 : 03/15/10

* Swtiches testing to Tinytest
* Adds basic functionality
* Adds sample output file and rake task
