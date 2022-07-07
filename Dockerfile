
FROM gcr.io/datamechanics/spark:3.0.2-hadoop-3.2.0-java-8-scala-2.12-python-3.8-dm13

ARG R_VERSION="4.0.4"
ARG LIBARROW_BINARY="true"
ARG RSPM_CHECKPOINT=2696074
ARG CRAN="https://packagemanager.rstudio.com/all/__linux__/focal/${RSPM_CHECKPOINT}"

USER root

RUN echo "deb http://cloud.r-project.org/bin/linux/debian buster-cran40/" >> /etc/apt/sources.list \
    && apt-key adv --keyserver keys.gnupg.net --recv-key 'E19F5F87128899B192B1A2C2AD5F960A256A04AF'

RUN apt-get update -yqq \
    && apt-get upgrade -yqq \
    && apt-get install -y --no-install-recommends \
        git \
        jq \
        libcurl4-openssl-dev \
        libgit2-dev \
        libmagick++-dev \
        libpq-dev \
        libsecret-1-dev \
        libsodium-dev \
        libssl-dev \
        libxml2-dev \
        ssh \
        wget \
    && apt-get install -y --no-install-recommends -t \
        buster-cran40 r-base \
        r-base-dev \
        r-recommended

RUN Rscript -e "install.packages(c('littler', 'docopt'), repo = 'https://cloud.r-project.org/')"

RUN ln -fs /usr/local/lib/R/site-library/littler/bin/r /usr/bin/r \
    && ln -fs /usr/local/lib/R/site-library/littler/examples/install2.r /usr/bin/install2.r \
    && ln -fs /usr/local/lib/R/site-library/littler/examples/installGithub.r /usr/bin/installGithub.r

RUN install2.r  --error \
    arrow \
    devtools \
    remotes \
    renv \
    sparklyr \
    tidyverse \
    nycflights13 \
    Lahman \
    lemon \
    AzureStor \
    bibliometrix

RUN mkdir /opt/spark/work-dir/R
COPY *.R /opt/spark/work-dir/R