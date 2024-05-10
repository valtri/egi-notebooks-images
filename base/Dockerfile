# lab-4.1.8
# notebook-7.1.3
# python 3.11.9
FROM quay.io/jupyter/datascience-notebook:2024-05-06

USER root

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        less \
        graphviz \
        vim \
        openssh-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN curl https://raw.githubusercontent.com/kadwanev/retry/master/retry \
         -o /usr/local/bin/retry && chmod +x /usr/local/bin/retry

USER $NB_UID

# install mamba which goes way faster than conda
RUN conda install mamba -y --quiet -c conda-forge \
    && mamba install -y -q \
        r-plotly \
        r-gdata \
        rdflib \
        prov \
        graphviz \
        pydot \
        lxml \
        geojson \
        pydap \
        xarray \
        cartopy \
        ipyleaflet \
        jupyter-server-proxy \
    && conda clean --all

RUN pip install --no-cache-dir \
        shortid \
        nbgitpuller

WORKDIR "${HOME}"

RUN NODE_OPTIONS="--openssl-legacy-provider" \
    jupyter labextension install \
        @jupyter-widgets/jupyterlab-manager jupyter-leaflet
