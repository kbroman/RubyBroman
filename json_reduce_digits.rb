#!/usr/bin/env ruby

# reduce the number of digits in a json file
# (this reduces to 4 digits past decimal)

ifilename = ARGV[0]
ofilename = ifilename.sub(/(.+)\.json/, '\1_rev.json')

print "#{ifilename} -> #{ofilename}\n"

ofile = open(ofilename, 'w')
open(ifilename).each do |line|
    ofile.print line.gsub(/(\d+\.\d\d\d\d)\d+/, '\1')
end
