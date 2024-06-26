ARG BASE_IMAGE=eginotebooks/base:latest
# hadolint ignore=DL3006
FROM $BASE_IMAGE

USER root

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        nco \
        cdo \
        gdal-bin \
        cmake \
        libgdal-dev=3.0.4+dfsg-1build3 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER $NB_UID

RUN mamba install -y --quiet \
        basemap \
        beakerx \
        xgboost \
        lightgbm \
        catboost \
        netcdf4 \
        aiohttp \
        graph-tool \
        scikit-learn==0.22.1 \
        scikit-mobility \
        dask-jobqueue \
        fs \
        rasterio \
        contextily \
        nb_conda_kernels \
        nb_conda \
        pyophidia \
    && conda clean -tipsy

RUN conda create --quiet --yes -n java8 \
    && mamba install -n java8 --yes openjdk=8 \
    && conda clean -tipsy

ENV CPLUS_INCLUDE_PATH=/usr/include/gdal
ENV C_INCLUDE_PATH=/usr/include/gdal

# Pinned networkx to 2.6.3 as 2.7 makes networksns fail
RUN pip install --no-cache-dir \
        bicm \
        rdp \
        oceans \
        sentinelhub \
        import_ipynb \
        nbresuse \
        ndlib \
        motuclient \
        panel==0.9.* \
        cdlib[C]==0.2.3 \
        cython \
        node_conformity \
        git+https://github.com/obidam/pyxpcm.git \
        git+https://github.com/geopython/OWSLib.git \
        git+https://github.com/euroargodev/argopy.git@master \
        git+https://github.com/guglielmocola/RetweetCascade.git@f96319d0107473715104acceb2ff0925d35dd9e3 \
        fast-forward-indexes \
        NEMtropy \
        folium==0.11.0 \
        geopy==2.0.0 \
        hvplot==0.6.0 \
        intake==0.6.0 \
        intake-esm==2020.8.15 \
        hda \
        seaborn==0.11.0 \
        zarr==2.5.0 \
        holoviews \
        networkx==2.6.3 \
        networksns \
        GDAL==3.0.4 #need to match the version of gdal installed

# Julia Updates and packages installations
# See https://support.d4science.org/issues/22065
RUN julia --eval 'using Pkg; Pkg.pin("IJulia")' \
    && julia --eval "using Pkg; Pkg.update()" \
    && julia --eval 'using Pkg; Pkg.add(["Images","VideoIO"])' \
    && julia --eval 'using Pkg; Pkg.add(url="https://github.com/gher-ulg/DIVAndNN.jl")' \
    && julia --eval 'using Pkg; Pkg.add(["JSON", "PyCall", "PyPlot", "DIVAnd", "Glob", "DataStructures", "NCDatasets"])'

RUN jupyter labextension install jupyterlab-topbar-extension jupyterlab-system-monitor
RUN jupyter labextension disable @jupyterlab/filebrowser-extension:share-file
