# parseExcel: parse a simple Excel file
#     calculate mean and SD of 2nd column

require 'Roo' # gem for parsing spreadsheets

s = Roo::Excelx.new("data.xlsx")

# first row is header; put rest into a hash
value = {}
2.upto(s.last_row).each { |row| value[s.cell(row,1)] = s.cell(row,2) }

# calculate mean and SD
n = value.keys.length
sum = value.keys.reduce(0) { |sum,key| sum + value[key] }
sumsq = value.keys.reduce(0) { |sum,key| sum + (value[key]*value[key]) }
mean = sum/n
sd = Math.sqrt((sumsq - sum*sum/n)/(n-1))

printf("   n = %5d\n", n)
printf("mean = %5.2f\n", mean)
printf("  SD = %5.2f\n", sd)
