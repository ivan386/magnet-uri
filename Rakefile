require 'rake/testtask'

namespace :gem do
  desc 'Build the gem'
  task :build do
    sh 'gem build magnet-uri.gemspec'
  end

  desc 'Upload the gem to rubygems.org'
  task :upload do
    sh 'gem push *.gem'
  end
end

Rake::TestTask.new do |t|
  t.libs << 'test'
end

desc 'Run tests'
task :default => :test
