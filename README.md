# crayon

### current version : 1.1.0

[http://github.com/mikowitz/crayon][github]

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

## Return values

Crayon simply returns a formatted string

    Color.red("red, ").blue("and blue") #=> "\e[31mred, \e[0m\e[34mand blue\e[0m"

So any call to `Crayon` must be `puts` or `print`-ed in order for the content to be displayed with the proper coloring.

## Copyright

Copyright (c) 2010 Michael Berkowitz. See LICENSE for details.

[github]: http://github.com/mikowitz/crayon "Crayon repository"
