FROM python:3

WORKDIR /opt

ENV CPATH=/usr/include/gdal:/usr/local/include/python3.7m PYTHONUNBUFFERED=1

RUN apt update && apt install -y sqlite3 libsqlite3-dev g++ python3-dev \
    && wget http://download.osgeo.org/proj/proj-6.0.0.tar.gz \
    && tar -xvzf proj-6.0.0.tar.gz \
    && cd proj-6.0.0 \
    && ./configure \
    && wget http://download.osgeo.org/proj/proj-datumgrid-1.8.zip \
    && unzip -o proj-datumgrid-1.8.zip -d data/ \
    && make && make install
RUN cd /opt \
    && git clone https://github.com/libgeos/geos.git \
    && cd geos && ./autogen.sh && mkdir obj && cd obj && ../configure \
    && make && make check && make install
RUN cd /opt \
    && wget http://download.osgeo.org/gdal/2.4.1/gdal241.zip \
    && unzip gdal241.zip && cd gdal-2.4.1 \
    && ./configure && make && make install

ENV CPATH=/usr/local/lib LD_LIBRARY_PATH=/usr/local/lib
