# JBrowse
# VERSION 1.0
FROM nginx
# FROM finizco/nginx-node:latest
ENV DEBIAN_FRONTEND noninteractive


RUN mkdir -p /usr/share/man/man1 /usr/share/man/man7


# WORKDIR /jbrowse
RUN apt-get -qq update --fix-missing
RUN apt-get --no-install-recommends -y install build-essential zlib1g-dev libxml2-dev libexpat-dev postgresql-client libpq-dev libpng-dev wget unzip perl-doc ca-certificates curl
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt-get --no-install-recommends -y install nodejs
RUN apt-get --no-install-recommends -y install git
RUN apt-get --no-install-recommends -y install python-dev

# wget https://github.com/shouldsee/jbrowse/archive/docker.tar.gz

ADD docker.tar.gz /download/
RUN ln -s /download/* /jbrowse
# RUN ls /jbrowse
#ADD https://github.com/shouldsee/jbrowse/tarball/master /jbrowse/

WORKDIR /jbrowse/
COPY jbrowse/setup.sh /jbrowse/
# RUN sw_vers
# RUN ./setup.sh && \
#     ./bin/cpanm --force JSON Hash::Merge PerlIO::gzip Devel::Size \
#     Heap::Simple Heap::Simple::XS List::MoreUtils Exception::Class Test::Warn Bio::Perl \
#     Bio::DB::SeqFeature::Store File::Next Bio::DB::Das::Chado && \
#     rm -rf /root/.cpan/
RUN ./setup.sh
# RUN perl Makefile.PL && make && make install
RUN rm -rf /usr/share/nginx/html && ln -s /jbrowse/ /usr/share/nginx/html


RUN ln -sf /data/jbrowse /jbrowse/data

VOLUME /data
COPY docker-entrypoint.sh /
CMD ["/docker-entrypoint.sh"]
