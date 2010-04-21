require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "crayon"
    gem.summary = %Q{a new version of 'color' with a less common name.}
    gem.description = %Q{A simple, flexible gem that provides an open-ended API to print colored and styled output to the terminal.}
    gem.email = "michael.berkowitz@gmail.com"
    gem.homepage = "http://github.com/mikowitz/crayon"
    gem.authors = ["Michael Berkowitz"]
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << "lib" << "spec"
  spec.spec_files = FileList["spec/**/*_spec.rb"]
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << "lib" << "spec"
  spec.pattern = "spec/**/*_spec.rb"
  spec.rcov = true
end

task :spec => :check_dependencies
task :default => :spec

desc "'Proof is the bottom line for everyone' -- Paul Simon"
task :proof do
  system "ruby test/proof.rb"
end

begin
  require 'yard'
  YARD::Rake::YardocTask.new do |t|
    t.options = ['--no-private', '-mmarkdown']
  end
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end
