#!/usr/bin/env ruby
# replace spaces in a file name with underscores

file = ARGV.join(' ')
newfile = file.gsub(/\s+/, '_')
puts "#{file} -> #{newfile}"
`mv "#{file}" "#{newfile}"`
