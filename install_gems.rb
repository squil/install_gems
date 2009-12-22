#! /usr/bin/ruby
require 'rubygems'

filename = ARGV[0]

File.open(filename, 'r') do |document|
  while line = document.gets 
    next if line.empty?

    line =~ /^(\S+) \((.+)\)$/
    gem_name = $1
    versions = $2.split(', ')

    versions.each do |version|
      unless Gem.available?(gem_name, version)
        puts "Installing #{gem_name} #{version}"
        system "gem install #{gem_name} -v=#{version}"
      end
    end
  end
end
