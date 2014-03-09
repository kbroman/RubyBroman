#!/usr/bin/env ruby
#
# from the files in a .Rd subdirectory, attempt to convert to R
# comment format that Roxygen2 would want.



def findField (string, field)
  return "" unless string =~ /\\#{field}\{(.*)\}/m

  processField($1)
end  

def processField (string)
  nleftbrace = 0
  for i in 0..string.length
    nleftbrace += 1 if string[i] == "{"
    nleftbrace -= 1 if string[i] == "}"
    return string[0..(i-1)] if nleftbrace < 0
  end
  string
end
    
def findItems (string)
  string.scan(/\\item\{([^\}]+)\}\s*\{([^\{]+)\}/m)
end  

def convert4comment (string)
  string = string.strip
  string = string.sub(/^\n/, '')
  string = string.gsub(/\n\s*\n/, "\n")
  string = string.gsub("\n", "\n#' ")
  string = string.gsub("@", "@@")
  "#' #{string}\n"
end


def parseRdfile (filename)
  contents = File.open(filename).readlines.join('')

  # name of function as name of file
  name = findField(contents, "name")
  rcomment = "#  #{name}\n"

  # title
  ["title", "description"].each do |field|
    value = findField(contents, field)
    rcomment += "#'\n"
    rcomment += convert4comment(value)
  end

  # arguments/param
  value = findField(contents, "arguments")
  args = findItems(value)

  args.each do |arg|
    rcomment += "#'\n"
    rcomment += "#' @param #{arg[0]} "
    rcomment += convert4comment(arg[1])
  end

  fields = {"details" => "details",
            "value" => "return",
            "author" => "author",
            "examples" => "examples",
            "seealso" => "seealso",
            "keyword" => "keywords"}

  fields.each do |key, newkey|
    value = findField(contents, key)
    next if value == ""

    # add @export just after @return
    rcomment += "#'\n#' @export\n" if key == "value"

    rcomment += "#'\n"
    rcomment += "#' @#{newkey}\n"
    rcomment += convert4comment(value)
  end


  [name, rcomment]
end

def parseRdfiles (files)
  Hash[files.map { |file| parseRdfile(file) }]
end

def writeRcomments (mandir, comments)
  comments.each do |name, comment|
      filename = "#{mandir}/#{name}.R"
      ofile = File.open(filename, "w")
      ofile.write(comment)
      ofile.close
  end
end

def insertRcomments (rfilename, comments)
  funcnames = comments.keys

  rcode = File.open(rfilename).readlines
  
  ofile = File.open(rfilename, "w")

  rcode.each do |line|
    if line =~ /<-/
      funcnames.each do |funcname|
        ofile.write(comments[funcname]) if line =~ /^#{funcname}\s+<-/
      end
    end
    ofile.write(line)
  end

end


### now to the work

pkgdir = ARGV.length > 0 ? ARGV[0] : abort("Give package directory")
mandir = "#{pkgdir}/man"

# files in that directory
rdfiles = Dir["#{mandir}/*.Rd"]
abort(%-No Rd files in directory "#{mandir}"-) unless rdfiles.length > 0
puts "Reading from #{rdfiles.length} Rd files"

comment_hash = parseRdfiles(rdfiles)

writeRcomments(mandir, comment_hash)

rdir = "#{pkgdir}/R"
rfiles = Dir["#{rdir}/*.R"]
puts "Writing to #{rfiles.length} R files"
rfiles.each { |file| insertRcomments(file, comment_hash) }
