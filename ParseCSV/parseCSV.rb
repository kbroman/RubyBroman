# parseCSV: parse a simple CSV file
#     calculate mean and SD of 2nd column

file = File.open("data.csv")
head = file.readline # header row

# put rest of rows into a hash
value = {}
file.readlines.each do |z| 
  z = z.split(",")
  value[z[0]] = z[1].to_f
end

# calculate mean and SD
n = value.keys.length
sum = value.keys.reduce(0) { |sum,key| sum + value[key] }
sumsq = value.keys.reduce(0) { |sum,key| sum + (value[key]*value[key]) }
mean = sum/n
sd = Math.sqrt((sumsq - sum*sum/n)/(n-1))

printf("   n = %5d\n", n)
printf("mean = %5.2f\n", mean)
printf("  SD = %5.2f\n", sd)
