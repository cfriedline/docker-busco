## Build the image

You'll need to have a working [docker](http://www.docker.com) installation.

`Clone` this repo, `cd` to the directory, type `docker-compose up`

The build is also available on Docker Hub: `docker pull cfriedline/busco`

## Execute with [docker](http:///www.docker.com)

```bash
docker run \
cfriedline/busco \
python3 /busco/BUSCO_v1.1b1/BUSCO_v1.1b1.py \
-o gm -in \
/input/genome.ctg.fasta \
-l /busco/arthropoda \
-m genome \
-c 8 \
-e 0.001 \
-f \
-sp generic
```

This command does the following, YMMV:

1. Maps my downloads directory to both `/input` and `/results` in the container
2. Sets the name prefix using `-o` to `gm` (which is written to my `Downloads` folder)
3. Uses my genome assembly that I've downloaded into `Downloads` (mapped to `input`)
4. Sets the correct lineage (`-l`)
5. Runs the genome mode using `-m` (others are `ogs` and `trans`)
6. Sets the number of CPUs (`-c`)
7. Sets an e-value cutoff (`-e`)
8. Forces overwrite (`-f`)

Make sure to consult the BUSCO [manual](http://busco.ezlab.org/files/BUSCO_userguide.pdf) and
[README](http://busco.ezlab.org/files/README.html)

Additional convenience make targets are also provided (e.g., `shell`)

Enjoy!

`BibTeX` citation for `BUSCO`

```
@article{Simao:2015kk,
author = {Sim{\~a}o, Felipe A and Waterhouse, Robert M and Ioannidis, Panagiotis and Kriventseva, Evgenia V and Zdobnov, Evgeny M},
title = {{BUSCO: assessing genome assembly and annotation completeness with single-copy orthologs.}},
journal = {Bioinformatics},
year = {2015},
volume = {31},
number = {19},
pages = {3210--3212},
month = oct
}
```
