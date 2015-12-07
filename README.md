## Build the image

You'll need to have a working docker installation.

`Clone` this repo, `cd` to the directory, type `make`

## Execute with docker

```bash
docker run \
-v /Users/chris/Downloads:/input \
-v /Users/chris/Downloads:/results \
cfriedline/busco \
python3 /busco/BUSCO_v1.1b1/BUSCO_v1.1b1.py \
-o gm -in \
/input/genome.ctg.fasta \
-l /busco/arthropoda \
-m genome
```

This command does the following, YMMV:

1. Maps my downloads directory to both `/input` and `/results` in the container
2. Sets the name prefix using `-o` to `gm` (which is written to my `Downloads` folder)
3. Uses my genome assembly that I've downloaded into `Downloads` (mapped to `input`)
4. Sets the correct lineage (`-l`)
5. Runs the genome mode using `-m` (others are `ogs` and `trans`)

Make sure to consult the BUSCO [manual](http://busco.ezlab.org/files/BUSCO_userguide.pdf) and
[README](http://busco.ezlab.org/files/README.html)

Additional convience make targets are also provided (e.g., `shell`)

Enjoy!
