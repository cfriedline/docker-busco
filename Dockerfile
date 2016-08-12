FROM phusion/baseimage:0.9.19

MAINTAINER Chris Friedline <cfriedline@vcu.edu>

RUN \
sed -i 's%archive.ubuntu.com%mirrors.gigenet.com/ubuntuarchive/%' /etc/apt/sources.list && \
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
parallel --bar wget http://busco.ezlab.org/files/{}_buscos.tar.gz ::: \
arthropoda vertebrata fungi bacteria metazoa eukaryota


RUN \
cd /busco && \
parallel --bar wget ::: \
ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.2.30/ncbi-blast-2.2.30+-x64-linux.tar.gz \
http://eddylab.org/software/hmmer3/3.1b2/hmmer-3.1b2-linux-intel-x86_64.tar.gz \
http://bioinf.uni-greifswald.de/augustus/binaries/augustus-3.2.2.tar.gz \
http://busco.ezlab.org/files/BUSCO_v1.22.tar.gz


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
cd bamtools && mkdir build && cd build && \
cmake .. && \
make && \
make install

RUN \
ln -s /usr/local/include/bamtools /usr/include/bamtools && \
ln -s /usr/local/lib/bamtools/* /usr/local/lib && \
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
$BUSCO_extra
