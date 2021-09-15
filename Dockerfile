FROM ubuntu:bionic

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update \
 && apt install -y software-properties-common \
                   python3-pip \
                   git \
                   openjdk-8-jre

# Install Python 3.7 and Pandas 1.0.3
RUN add-apt-repository -y ppa:deadsnakes/ppa \
 && apt install -y python3.7 \
 && python3.7 -m pip install pandas==1.0.3

# Install R 3.6 and required packages
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 \
 && add-apt-repository -y "deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/" \
 && apt install -y r-base \
 && Rscript -e "install.packages(commandArgs(trailingOnly = TRUE))" \
      argparse \
      stringr \
      purrr \
      dplyr \
      multidplyr \
      tidyr \
      data.table \
      parallel \
      rcompanion

# Install HLA-TAPAS and copy helper scripts
RUN git clone https://github.com/immunogenomics/HLA-TAPAS.git
COPY HLA-TAPAS NomenCleaner MakeReference SNP2HLA HLAassoc HLAManhattan /usr/local/bin
WORKDIR /HLA-TAPAS
