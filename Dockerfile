FROM ubuntu:14.04.3
MAINTAINER Eric Lyons
RUN apt-get update && apt-get install -y \
   build-essential \
   git \
   python
ENV BINPATH /usr/bin
ENV SRCPATH /usr/src
ENV HISAT2GIT https://github.com/infphilo/hisat2.git
ENV HISAT2PATH $SRCPATH/hisat2
RUN mkdir -p $SRCPATH
WORKDIR $SRCPATH
# Clone and checkout the 2.0.3-beta release version of the git repo
RUN git clone "$HISAT2GIT" \
   && cd $HISAT2PATH \
   && git checkout 3f8c81375700d4107fdfd1caeaec01b5719ae4b8
RUN  make -C $HISAT2PATH \
   && cp $HISAT2PATH/hisat2 $BINPATH \
   && cp $HISAT2PATH/hisat2-* $BINPATH
ENTRYPOINT ["/usr/bin/hisat2"]
