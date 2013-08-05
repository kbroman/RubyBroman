# Combine the data in "genotypes.txt", "markers.txt" and "families.txt"
# and convert them into a CRI-MAP .gen file
#
# This is a ruby version of the perl script discussed in my "Intro to perl"
# at http://www.biostat.wisc.edu/~kbroman/perlintro/index.html#ex2

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
    @sex = "0" if @sex == "2" # convert from 1/2 to 1/0
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
    vals = line.strip.split(/\s+/) # strip removes leading and ending white space
    person = Person.new(*vals)     # *vals makes vals elements separate arguments
    people[person.famid] = person
  end
  people
end
    
# clean up string - > genotype
def parse_genotype (string)
  string = string.gsub(/\s/, "")
  string = "0/0" if string == ""
  string.sub(/\//, " ")
end

# read genotype data, fill in genotypes within people hash
def read_genotypes (filename, people)
  file = File.open(filename)

  header = file.readline.strip.split(/\s+/)
  header.shift # omit the first field, "Marker"

  file.readlines.each do |line|
    marker = line[0..8].gsub(/\s/, "")
    line = line[9..-1]
    header.each_with_index do |person, i|
      start = i*7
      people[person].gen[marker] = parse_genotype line[start..(start+6)]
    end
  end
end

# distinct families
def get_families (people)
  people.keys.map {|id| id.split(/\-/)[0]}.uniq
end

# people within a family
def get_family_members (people, family)
  people.select { |key,person| person.family == family }
end

def write_genfile (filename, people, markers)
  file = File.open(filename, "w")
  
  families = get_families(people)
  file.write("#{families.length}\n")

  file.write("#{markers.length}\n")
  markers.each {|marker| file.write(marker + "\n") }

  families.each do |family|
    file.write("#{family}\n")
    members = get_family_members(people, family)
    file.write("#{members.length}\n")

    members.each do |key,person|
      file.write("#{person.id} #{person.mom} #{person.dad} #{person.sex}\n")

      markers.each do |marker|
        file.write(person.gen[marker] + " ")
      end
      file.write("\n")
    end
  end
end

# read the data
markers = read_markers(mfile)
people = read_families(ffile)
read_genotypes(gfile, people)

# write the data
write_genfile(ofile, people, markers)
