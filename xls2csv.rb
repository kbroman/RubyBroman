#!/usr/bin/env ruby
#
# xls2csv.rb   :    Karl Broman, 15 Oct 2013, MIT License
#
#   Split an excel file into a number of CSV files, one per sheet
#   Run as follows:
#
#      xls2csv.rb inputfile [outputstem] [separator]
#
# if inputfile is file.xls and outputstem is not given,
#     output files will be like file_[sheetname].csv
#
# The default separator is ','
# If some fields contain commas, you might use '|'

require 'Roo' # gem for parsing spreadsheets

# file name, stem is the part before .xls or .xlsx
file = ARGV.length > 0 ? ARGV[0] : abort("Give file name")
if file =~ /^(.+)\.xlsx?$/
  stem = $1
else
  abort("File name doesn't look right")
end

# output stem might be 2nd argument
stem = ARGV[1] if ARGV.length > 1

# separator for output; default is comma
sep = ARGV.length > 2 ? ARGV[2] : ","

# the file
s = Roo::Excelx.new(file)

# look for separator in cell
def check4sep (cell, sep, sheetname, row, column)
  if !(cell.nil?) and cell.to_s.count(sep)>0
    puts %|separator found in sheet #{sheetname} : (#{row}, #{column}) : "#{cell}"|
  end
end

# function to write a sheet to a file
def write_sheet (filename, sheet, sheetname, sep)
  puts "#{sheetname} -> #{filename}"
  file = File.open(filename, "w")

  1.upto(sheet.last_row) do |row|
    file.write(sheet.cell(row,1))
    check4sep(sheet.cell(row,1), sep, sheetname, row, 1)
    if sheet.last_column > 1
      2.upto(sheet.last_column) do |column|
        file.write("#{sep}#{sheet.cell(row,column)}")
        check4sep(sheet.cell(row,column), sep, sheetname, row, column)
      end
    end
    file.write("\n")
  end
end

# loop over sheets
s.sheets.each do |sheetname|
  # skip sheet if empty
  next if s.sheet(sheetname).last_row.nil? or s.sheet(sheetname).last_column.nil?

  # replace spaces in filenames with underscores
  filename = "#{stem}_#{sheetname}.csv".gsub(/\s+/, '_')
  write_sheet(filename, s.sheet(sheetname), sheetname, sep)
end
