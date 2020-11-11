#!/usr/bin/env rake

Dir.glob('lib/tasks/*.rake').each { | rake_file | import rake_file }
task :default => [:spec,'analyzer:all']