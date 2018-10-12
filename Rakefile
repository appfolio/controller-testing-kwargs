require "bundler/gem_tasks"
require "rake/testtask"
require "rspec/core/rake_task"

Rake::TestTask.new(:test_minitest) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList['test/**/*_test.rb']
end

RSpec::Core::RakeTask.new(:test_rspec)

task :default => [:test_minitest, :test_rspec]
