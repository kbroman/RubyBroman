# Combine the data in "genotypes.txt", "markers.txt" and "families.txt"
# and convert them into a CRI-MAP .gen file
#
# This is a ruby version of the perl script discussed in my "Intro to perl"
# at http://www.biostat.wisc.edu/~kbroman/perlintro/

# file names
gfile = "genotypes.txt" # genotype data
mfile = "markers.txt"   # list of markers, in order
ffile = "families.txt"  # family information
ofile = "data.gen"      # output file

def read_markers (filename)
  File.open(filename).readlines.map {|str| str.strip}
end

class Person
  attr_accessor :family, :id, :dad, :mom, :sex, :famid, :gen
  def initialize (family, id, dad, mom, sex)
    @family = family
    @id = id
    @dad = dad
    @mom = mom
    @sex = sex
    @famid = "#{family}-#{id}"
    @gen = {}
  end
end

# read family info and return a hash of people
def read_families (filename)
  file = File.open(filename)
  file.readline # header row
  people = {}
  file.readlines.each do |line|
    vals = line.split(/\s+/)
    vals.shift if vals[0] == "" # deal with leading spaces
    person = Person.new(*vals)
    people[person.famid] = person
  end
  people
end
    
# read genotype data, fill in genotypes within people hash
def read_genotypes (filename, people)
  file = File.open(filename)

  header = file.readline.split(/\s+/)
  header.shift if header[0] == ""
  header.shift # omit the first field, "Marker"

  file.readlines.each do |line|
    marker = line[0..8].gsub(/\s/, "")
    line = line[9..-1]
    header.each_with_index do |person, i|
      start = i*7
      genotype = line[start..(start+7)].gsub(/\s/, "").split(/\//)
      people[person].gen[marker] = genotype.join(" ")
    end
  end
end

# unique values for a vector
def unique (arr)
  h = {}
  arr.each { |z| h[z] = 1 }
  h.keys
end

# distinct families
def families (people)
  unique people.keys.map {|id| id.split(/\-/)[0]}
end

# people within a family
def family_members (people, family)
  people.select { |key| people[key].family == family }
end

def write_genfile (filename, people, markers)
  file = File.open(filename, "w")
  
end


# read the data
markers = read_markers(mfile)
people = read_families(ffile)
read_genotypes(gfile, people)

puts families(people).join("|")
puts people.keys.join("|")
puts family_members(people, "1").keys.join("|")
