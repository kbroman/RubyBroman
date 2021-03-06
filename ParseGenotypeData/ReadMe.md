## ParseGenotypeData

Ruby version of the [long example perl script](http://www.biostat.wisc.edu/~kbroman/perlintro/index.html#ex2) in my
[Intro to perl](http://www.biostat.wisc.edu/~kbroman/perlintro/).

The goal is to take three files obtained from a collaborator (genotype
data, family info, and order of markers) and combine them into a
single file in the format used by the CRI-MAP program.

- `genotypes.txt` &mdash; genotype data
- `families.txt` &mdash; family information
- `markers.txt` &mdash; ordered markers
- `data_save.gen` &mdash; desired output file
- `convert.pl` &mdash; original perl script
- `convert.rb` &mdash; ruby script

Also see the [Python version](https://github.com/kbroman/PyBroman/blob/master/ParseGenotypeData/convert.py).
