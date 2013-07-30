# generate a CSV  file with two columns: a random individual ID + a random number

require 'GSL' # interface to gnu scientific library

# generate random (distinct) IDs in the range 1-1000
n_ind = 50
ids = (1..1000).to_a.shuffle[1..n_ind]

# generate random outcomes, following Normal(mean=20, sd=6)
rng = GSL::Rng.alloc
values = rng.gaussian(6, n_ind).to_a.map { |x| x+20 }

# write to file
file = File.open('data.csv', 'w')
file.write("ID,outcome\n")
values.each_with_index { |val, index| file.write("#{ids[index]},#{val}\n") }
