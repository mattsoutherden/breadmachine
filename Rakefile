require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "breadmachine"
    gem.summary = "Make dough with Bread Machine; a ruby library for payment processing."
    gem.description = "BreadMachine facilitates payment processing, including 3-D Secure, with the SecureTrading XPay gateway"
    gem.email = "matt@localbubble.com"
    gem.homepage = "http://github.com/mattsoutherden/breadmachine"
    gem.authors = ["Matt Southerden"]
    gem.rubyforge_project = "breadmachine"
    
    gem.files = FileList['lib/**/*.rb'].to_a
    
    gem.add_dependency "money"
    gem.add_dependency "nokogiri"
    gem.add_dependency "builder"
    gem.add_dependency "activesupport"
    
    gem.add_development_dependency "rake"
    gem.add_development_dependency "rspec"
    gem.add_development_dependency "notahat-machinist"
    gem.add_development_dependency "cucumber"
    gem.add_development_dependency "rest-client"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::RubyforgeTasks.new do |rubyforge|
    rubyforge.doc_task = "rdoc"
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "breadmachine #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'metric_fu'
rescue LoadError
  puts "Metric-Fu not available."
end