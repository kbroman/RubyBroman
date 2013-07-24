#!/usr/bin/env ruby
# text summarizer from Ch 4 of Beginning Ruby
# sample text: http://www.rubyinside.com/book/oliver.txt

file = ARGV.length > 0 ? ARGV[0] : "oliver.txt"
puts "Reading from #{file}"

text = File.readlines(file)
n_lines = text.length # or text.size
text = text.join
n_char = text.length
n_word_char = text.gsub(/\s+/, "").length
n_words = text.split.length
n_sentences = text.split(/\.|\?|!/).length
n_para = text.split(/\n\n/).length

puts "no. lines = #{n_lines}"
puts "no. char  = #{n_char}"
puts "no. word char = #{n_word_char}"
puts "no. words = #{n_words}"
puts "no. sentences = #{n_sentences}"
puts "no. paragraphs = #{n_para}"

printf "ave words per sentence = %.1f\n", n_words.to_f / n_sentences.to_f
printf "ave sentences per para = %.1f\n", n_sentences.to_f / n_para.to_f
