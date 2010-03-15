= crayon

=== current version : 0.0.2

http://github.com/mikowitz/crayon

== Description

A simple, flexible gem that provides an open-ended API to print colored and styled output to the terminal.

== Installation

Install the gemcutter gem
  ~$ gem install gemcutter
Add gemcutter.org to your gem remote sources
  ~$ gem tumble
Download and install this gem
  ~$ gem install crayon

== Usage examples

To include this gem in a project
  require 'crayon'

The following are all methods that <code>Crayon</code> understands, and should give you an idea of what is possible.

  Crayon.blue("this will be printed as blue text")
  Crayon.on_red("this will be printed on a red background")
  Crayon.bold("this will be bold")
  Crayon.underline_blue_on_yellow("this will be underlined blue text on a yellow background")

The order of elements in the method name is also unimportant. For example

  Color.bold_underline_blue_on_yellow("sample text")

will look the same as

  Color.on_yellow_bold_blue_underline("sample text")

Check out <code>test/proof.rb"</code> and <code>`rake proof`</code> if you don't believe me.

== Copyright

Copyright (c) 2010 Michael Berkowitz. See LICENSE for details.

