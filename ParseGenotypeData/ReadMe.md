## ParseGenotypeData

Ruby version of the long example perl script in my
[Intro to perl](http://www.biostat.wisc.edu/~kbroman/perlintro/).

The goal is to take three files obtained from a collaborator (genotype
data, family info, and order of markers) and combine them into a
single file in the format used byt the CRI-MAP program.

- `genotypes.txt` &mdash; genotype data
- `families.txt` &mdash; family information
- `markers.txt` &mdash; ordered markers
- `data_save.gen` &mdash; desired output file
- `convert.pl` &mdash; original perl script
- `convert.rb` &mdash; ruby script