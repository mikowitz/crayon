# crayon

### current version : 1.0.3

[http://github.com/mikowitz/crayon][github]

### version warnings

* `puts` and `print` will be deprecated. `Crayon` will no longer contain an IO object, but will only return strings

## Description

A simple, flexible gem that provides an open-ended API to print colored and styled output to the terminal.

## Installation

Install the gemcutter gem

    ~$ gem install gemcutter

Add gemcutter.org to your gem remote sources

    ~$ gem tumble

Download and install this gem

    ~$ gem install crayon

## Usage examples

To include this gem in a project

    require 'crayon'

The following are all methods that `Crayon` understands, and should give you an idea of what is possible.

    Crayon.blue("this will be printed as blue text")
    Crayon.on_red("this will be printed on a red background")
    Crayon.bold("this will be bold")
    Crayon.underline_blue_on_yellow("this will be underlined blue text on a yellow background")

### `puts` and `print` deprecation warning

As of version 1.0.2, `puts` and `print` no longer control adding a newline to the end of Crayon-ed text. The methods themselves will remain in the code base until version 1.1.0, but will issue deprecation warnings, and have no real effect on the code. Instead of a line of code looking like this:

    Crayon.print.red("red, ").blue("blue, ").puts.green("and green")

you have a line of code like this:

    puts Crayon.red("red, ").blue("blue, ").green("and green")

This change is mostly due to the fact that defining Crayon's IO object would make using Crayon inside of another project more complicated than it would need to be. Crayon now simply returns a formatted string.

### chaining

You can also chain color calls without having to call `Crayon` multiple times

    Crayon.red("red").blue("blue").green("green")

### case flexibility

`Crayon` will also handle mixed-case method calls

    Crayon.ReD_ON_gREEN("It's Christmas!")

Of course, this is no different from calling

    Crayon.red_on_green("It's Christmas!")

## Flexibility

The order of elements in the method name is unimportant. For example

    Color.bold_underline_blue_on_yellow("sample text")

will look the same as

    Color.on_yellow_bold_blue_underline("sample text")

Check out `test/proof.rb` and `~$ rake proof` if you don't believe me.

## Copyright

Copyright (c) 2010 Michael Berkowitz. See LICENSE for details.

[github]: http://github.com/mikowitz/crayon "Crayon repository"
