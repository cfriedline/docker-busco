## Build the image

You'll need to have a working [docker](http://www.docker.com) installation.

`Clone` this repo and `cd` to the directory. Edit the `env` file
for what you need. Put your files in `input`.

To build and run: `docker-compose up`

The build is also available on Docker Hub. To use, change the line in the `yml` from `build .` to `image: cfriedline/busco`


Make sure to consult the BUSCO [manual](http://busco.ezlab.org/files/BUSCO_userguide.pdf) and
[README](http://busco.ezlab.org/files/README.html)

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
