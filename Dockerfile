FROM phusion/baseimage:0.9.19

MAINTAINER Chris Friedline <cfriedline@vcu.edu>

RUN \
sed -i 's%archive.ubuntu.com%mirror.math.princeton.edu/pub/ubuntu%' /etc/apt/sources.list && \
apt-get update && \
apt-get install -y \
curl \
git \
wget \
build-essential \
cmake \
python3 \
python3-dev \
libboost-iostreams-dev \
libz-dev \
libgsl0-dev \
libboost-graph-dev \
samtools \
libbam-dev \
vim \
emboss \
emboss-lib \
parallel

RUN mkdir /busco

RUN \
cd /busco && \
parallel --bar wget http://busco.ezlab.org/v1/files/{}_buscos.tar.gz ::: \
arthropoda vertebrata fungi bacteria metazoa eukaryota


RUN \
cd /busco && \
parallel --bar wget ::: \
ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.2.30/ncbi-blast-2.2.30+-x64-linux.tar.gz \
http://eddylab.org/software/hmmer3/3.1b2/hmmer-3.1b2-linux-intel-x86_64.tar.gz \
http://bioinf.uni-greifswald.de/augustus/binaries/old/augustus-3.2.2.tar.gz \
http://busco.ezlab.org/v1/files/BUSCO_v1.22.tar.gz


RUN \
cd /busco && \
parallel --bar tar xf ::: *.gz

ENV MAKEFLAGS "-j4"

RUN \
cd /busco/hmmer* && \
./configure && make && make install

RUN \
cd /busco && \
git clone https://github.com/pezmaster31/bamtools.git && \
cd bamtools && \
git checkout -b v2.4.1 v2.4.1 && \
mkdir build && cd build && \
cmake .. && \
make && \
make install

RUN \
ln -sf /usr/local/include/bamtools /usr/include/bamtools && \
ln -sf /usr/local/lib/bamtools/* /usr/local/lib

RUN \
cd /busco/augustus* && \
make

ENV AUGUSTUS_CONFIG_PATH=/busco/augustus-3.2.2/config/
ENV PATH=/busco/ncbi-blast-2.2.30+/bin:/busco/augustus-3.2.2/bin:$PATH

VOLUME /input

VOLUME /results

WORKDIR /results

CMD python3 $BUSCO_py \
-o $BUSCO_o \
-in $BUSCO_in \
-l $BUSCO_l \
-m $BUSCO_m \
-c $BUSCO_c \
-e $BUSCO_e \
-sp $BUSCO_sp \
$BUSCO_extra && \
cp -r $AUGUSTUS_CONFIG_PATH/species/$BUSCO_o /results

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
