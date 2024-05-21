# 2024-05-20
# julia-1.10.3
# lab-4.2.0
# notebook-7.2.0
# python-3.11.9
# r-4.3.3
FROM quay.io/jupyter/datascience-notebook:2024-05-20

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

# JupyterHub 5 beta
RUN pip install --no-cache-dir --pre \
        jupyterhub==5.0.0b2

RUN mamba install -y -q \
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
