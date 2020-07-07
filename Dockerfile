FROM ubuntu:18.04

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    openjdk-8-jdk gcc g++ make parallel maven subversion patch docker.io dos2unix wget

# Set environment variables
ENV JAVA_VER 8
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-amd64

# Create project directory
RUN mkdir /home/matchmaker

# Copy data to directory
COPY . /home/matchmaker

# Install matchmaker
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    bash ~/miniconda.sh -u -b -p /miniconda && \
    eval "$(/miniconda/bin/conda shell.bash hook)" && \
    conda init && \
    "/miniconda/bin/conda" create -n matchmaker python=3.8 -y --force && \
    conda activate matchmaker && \
    cd /home/matchmaker && \
    pip install -r requirements.txt && \
    python -m nltk.downloader stopwords && \
    python -m nltk.downloader punkt  && \
    python -m nltk.downloader wordnet && \
    cd algorithms/coma && \
    ./build_coma.sh