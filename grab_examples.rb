#!/usr/bin/env ruby

# a utility script I use to grab all example code from the .Rd files
# in my R package, R/qtlcharts (http://kbroman.org/qtlcharts),
# stripping off all \dontrun{} and \dontshow{} so that I can run
# _everything_, including things that open a web browser.

mandir = 'qtlcharts/man'
exdir = 'test_examples'
exfile = 'qtlcharts_ex.R'

Dir.mkdir(exdir) unless Dir.exists?(exdir)

ofilename = "#{exdir}/#{exfile}"
ofile = open(ofilename, 'w')
ofile.write("## Examples from qtlcharts help files\n")
ofile.write("library(qtlcharts)\n\n")

Dir.foreach(mandir) do |file|
    next unless file =~ /.Rd$/
    next if file == "print_qtlcharts_resources.Rd" # skip this one

    ofile.write("## #{file}\n")
    ofile.write("system.time({\n")

    filename = "#{mandir}/#{file}"
    f = open(filename)

    # look for start of examples
    f.each do |line|
        line.strip()
        break if line =~ /\\examples{/
    end

    num_braces = 0; # count braces to look for end
    f.each do |line|
        # get rid of dontshow and dontrun
        if line =~ /\\dontshow\{/ or line =~ /\\dontrun\{/
            line.sub!(/\\dontshow\{/, '')
            line.sub!(/\\dontrun\{/, '')
            num_braces += 1
        end

        if line =~ /\}/
            line.sub!(/\}/, '')
            num_braces -= 1
        end

        # end of examples?
        break if num_braces < 0

        # write line
        ofile.write(line)
    end

    ofile.write("})\n\n")
end    

