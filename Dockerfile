FROM ruby:2.1
RUN apt-get update && apt-get install nodejs=0.10.29~dfsg-2 imagemagick=8:6.8.9.9-5+deb8u5 libmagickwand-dev=8:6.8.9.9-5+deb8u5
ENV PATH /usr/lib/x86_64-linux-gnu/ImageMagick-6.8.9/bin-Q16:$PATH

WORKDIR /work/TACRM
COPY . $WORKDIR

RUN bundle install