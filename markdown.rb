#!/usr/bin/env ruby
# compile markdown to html (using R)

abort("Give a file name") if ARGV.length == 0
stem = ARGV[0]

# remove .md from stem
if /\.md\z/ =~ stem     # already ends in .md
  stem = $`             # the text before the match
end

# the markdown file
file = "#{stem}.md"

if File.exist?(file)
  `Rscript -e 'library(markdown);markdownToHTML("#{stem}.md", "#{stem}.html")'`
else
  print "#{file} does not exist.\n"
end
