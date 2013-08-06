#!/usr/bin/env ruby

# various ruby stuff while I learn the language
# following Peter Cooper's Beginning Ruby

# loops
1.upto(9) { |x| print x}
puts

9.downto(5) { |x| print x}
puts

0.step(20, 5) { |x| print "#{x} " }
puts

# string methods
print "Length of \"This is a test\""
puts 'This is a test'.length

puts "This is a test".downcase

puts "This is a test".upcase

puts "This is a test".swapcase

puts "This is a test".reverse

# string manipulation & reg ex
puts "foobarfoobar".sub('bar', 'foo')

puts "foobarfoobar".gsub('bar', 'foo')

puts "This is a test".sub(/\s+/, '|')

puts "This is a test".gsub(/\s+/, '|')

# --- scan creates array of patterns and applies a function to each
"This is a test".scan(/\w\w/) { |x| puts x}

# --- match returns 'match' object
m = "This is a test".match(/(\w+) (\w+)/)
puts "#{m[0]}|#{m[1]}|#{m[2]}"

puts "Blah blah blah. ".split(/\s+/).inspect

# arrays
[1, "test", 2, 3, 4].each {|x| print "#{x}X " }
puts
[1, "test", 2, 3, 4].each {|x| print x.to_s + "Y " }
puts

# map (aka collect)
# [1, 2, 3, 4, 5, 6]
x = 1.upto(6).map {|x| x }
puts x.length
y = x.map { |x| x*2}
puts y.join(" ")

# ranges to arrays
x = 1.upto(6).to_a
y = (1..6).to_a
z = 3.step(50, 5).to_a

# loops
for i in 1..5 
  puts "#{i}^2 = #{i**2}"
end

i = 1
while i <= 5
  puts "#{i}^2 = #{i**2}"
  i += 1
end

i = 1
until i > 5
  puts "#{i}^2 = #{i**2}"
  i += 1
end

# other array methods
x = (1..5).to_a
y = [2, 4, 1]
puts (x + y).join(":")
puts (x - y).join(":")
puts (x-y).empty?
puts (x-y).include?(3)
puts (x-y).include?("x")
puts (x-y).first
puts (x-y).last

z = (5..8).to_a
puts z.last(2).join("-")
puts z.reverse

# hashes
x = {"a" => 1, "b" => 2, "c" => 3}
x.each {|key, value| puts "#{key} -> #{value}" }
puts x.keys.join(" ")
x.delete("a")
puts x
x = {"a" => 1, "b" => 2, "c" => 3}
x.delete_if {|key,value| value == 2}
puts x

# ? operator
age = 10
type = age < 18 ? "child" : "adult"
puts "age = #{age} -> #{type}"

# code_block as argument to function/method
def map_vowel(&code_block)
  %w{a e i o u}.map {|v| code_block.call(v) }
end

puts map_vowel {|v| v*3} .join("|")

# equivalent to that?
def map_vowel2
  %w{a e i o u}.map {|v| yield v}
end

puts map_vowel2 {|v| v*3} .join("|")

# saving a code block
block = lambda {|v| v*3}

# don't escape in strings: use arbitrary delimiters
x = 'blah'
y = %-#{x} says, "Blah, blah, blah."-
z = 'or this, "Blah, blah."'
w = %<#{x} says, "Blah, blah, blah.">
t = %q<#{x} says, "Blah, blah, blah.">

# slices of arrays, negative index to start from end
a = 2.step(12, 2).to_a
p a[1..3]
p a[-1]
p a[-3 .. -2]

# symbols (literal constants that can have arbitrary value...the name is the important thing)
#     commonly used as keys for hashes
current_situation = :good
puts "Everything is fine" if current_situation == :good
puts "PANIC!" if current_situation == :bad

p person1 = { :name => "Fred",   :age => 24, :gender => :male }
p person2 = { :name => "Ginger", :age => 18, :gender => :female }

# conversion between classes
"5".to_i        # to integer
"6".to_f        # to float
"blah".to_sym   # to symbol
252.3.to_s      # to string

# a bit of text manipulation
text = %q{We may at once admit that any inference from the particular to the general must be attended with some degree of uncertainty, but this is not the same as to admit that such inference cannot be absolutely rigorous, for the nature and degree of the uncertainty may itself be capable of rigorous expression.} 
stopwords = %w{the a by on for of are with just but and to my in I has some}.map {|z| z.downcase}
words = text.downcase.scan(/\w+/)
keywords = words.select { |w| !stopwords.include?(w) }
puts keywords.join(" ")
puts %|no. char  = #{keywords.join(" ").length}|
puts "no. words = #{keywords.length}"

# playing with map
n = 8
counts = 1.upto(n).map { 0 }
puts counts.join(" ")
x = 1.upto(1000).map {|z| rand(8)}
x.each {|z| counts[z] = counts[z] + 1 }
puts counts.join(" ")

# looping over hashes (also sorting)
words = %w{We may at once admit that any inference from the particular to the general must be attended with some degree of uncertainty, but this is not the same as to admit that such inference cannot be absolutely rigorous, for the nature and degree of the uncertainty may itself be capable of rigorous expression.} 
words = words.map { |z| z.gsub(/[,\.]/, "") }
wordcount = {}
words.each { |z| wordcount[z] = wordcount[z].nil? ? 1 : wordcount[z] + 1 }
def by_count_and_length (a,b,hash)
  return a.length <=> b.length if hash[a] == hash[b]
  hash[a] <=> hash[b]
end
wordcount.keys.sort {|a,b| by_count_and_length(a,b,wordcount) }.each {|z| puts "#{z} => #{wordcount[z]}"}

# regex
puts "ok 1" if /AM/i =~ 'am'
puts "ok 2" if /\Ablah/ =~ "blah a number of special\nAll of these are"
puts "ok 3" unless /\AAll/ =~ "blah a number of special\nAll of these are"
puts "ok 4" if /^blah/ =~ "blah a number of special\nAll of these are"
puts "ok 5" if /^All/ =~ "blah a number of special\nAll of these are"
puts "ok 6" unless /special\z/ =~ "blah a number of special\nAll of these are"
puts "ok 7" if /are\z/ =~ "blah a number of special\nAll of these are"
puts "ok 8" if /special$/ =~ "blah a number of special\nAll of these are"
puts "ok 9" if /are$/ =~ "blah a number of special\nAll of these are"
puts "ok 10" unless /blah.*are/ =~ "blah a number of special\nAll of these are"
puts "ok 11" if /blah.*are/m =~ "blah a number of special\nAll of these are"
$x = "Today is 8/6/2013, while tomorrow is 8/7/2013."
if $x =~ /(\d+)\/(\d+)\/(\d+)/ # $~ contains info about
  puts "Month = #{$~[1]}, day = #{$~[2]}, year = #{$~[3]}"
  puts "Month = #{$1}, day = #{$2}, year = #{$3}"
  puts $& # matched text
  puts $` # text before the match
  puts $' # text after the match
  puts $+ # last bit of the match
end

# symbols and strings
the_string = :all.to_s
the_symbol = "all".to_sym
puts the_string.to_sym == the_symbol
puts the_string.to_sym.equal?(the_symbol)
puts the_symbol.to_s == the_string
puts (not the_symbol.to_s.equal?(the_string))
