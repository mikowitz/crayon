# crayon

### current version : 1.0.1

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

`Crayon` also provides intermediary methods `puts` and `print` which determine whether `Crayon` adds a newline to the end of the text being displayed.
By default, a newline is added.

    Crayon.puts.blue("this is on a line by itself.")
    Crayon.print.blue("the next line will be printed right next to this")
    Crayon.puts.green("this will on the second line of output, but will create a newline.")

`puts` and `print` set an internal, persistent variable, so a specified newline presence or absence will last until `puts` or `print` is invoked again.

    Crayon.print.blue("on the first line")
    Crayon.green("also on the first line")
    Crayon.red("also on the first line")
    Crayon.puts.cyan("Also on the first line, but with a trailing newline")
    Crayon.blue("On the second line by itself.")

You can also chain color calls without having to call `Crayon` multiple times

    Crayon.print.red("red").blue("blue").puts.green("green")

`Crayon` will also handle mixed-case method calls

    Crayon.ReD_ON_gREEN("It's Christmas!")

## Flexibility

The order of elements in the method name is unimportant. For example

    Color.bold_underline_blue_on_yellow("sample text")

will look the same as

    Color.on_yellow_bold_blue_underline("sample text")

Check out `test/proof.rb` and `~$ rake proof` if you don't believe me.

## Copyright

Copyright (c) 2010 Michael Berkowitz. See LICENSE for details.

[github]: http://github.com/mikowitz/crayon "Crayon repository"
