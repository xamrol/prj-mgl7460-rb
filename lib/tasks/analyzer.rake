require 'rubygems'
require 'term/ansicolor'
require 'reek/rake/task'

Reek::Rake::Task.new do |t|
  t.source_files = 'lib/uptime.rb'
  t.verbose = false
  t.fail_on_error = false
end

namespace :analyzer do
  desc "run all code analyzing tools (reek, flog, flay)"
  task :all => [:reek, :flog, :flay] do
    message(:info, 'have been running all code analyzing tools')
  end

  desc "run reek and find code smells"
  task :reek do
    message(:info, 'Running reek and find code smells')
    Rake::Task['reek'].invoke
  end

  desc "run flog and find the most tortured code"
  task :flog do
    message(:info, 'Running flog and find the most tortured code')
    sh 'flog -cad lib/uptime.rb'
  end

  desc "run flay and analyze code for structural similarities"
  task :flay do
    message(:info, 'Running flay and and analyze code for structural similarities')
    sh 'flay lib/uptime.rb'
  end
end

def message(type, message)
  set_color(type)
  puts message
  reset_color
end

def set_color(type)
  term = Term::ANSIColor
  colors = {info: term.green, error: term.red}
  puts colors[type]
end

def reset_color
  puts Term::ANSIColor.reset
end
