ARG BASE_IMAGE=eginotebooks/base:latest
# hadolint ignore=DL3006
FROM $BASE_IMAGE

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Enterprise Gateway
# see https://jupyter-enterprise-gateway.readthedocs.io/en/latest/developers/custom-images.html

USER root

RUN pip install pycrypto

RUN curl -L https://github.com/jupyter-server/enterprise_gateway/releases/download/v3.2.2/jupyter_enterprise_gateway_kernel_image_files-3.2.2.tar.gz | \
    tar -xz -C /usr/local/bin

# RUN adduser --system --uid 1000 --gid 100 jovyan && \
#     chown jovyan:users /usr/local/bin/bootstrap-kernel.sh && \
#     chmod 0755 /usr/local/bin/bootstrap-kernel.sh && \
#     chown -R jovyan:users /usr/local/bin/kernel-launchers

RUN fix-permissions /usr/local/bin

USER $NB_UID

# Octave, install on a different environment
# Octave from conda won't build packages
# see https://discourse.jupyter.org/t/installing-octave-packages-with-binder/4206
USER root

RUN apt-get update \
    && apt-get install --install-recommends -y \
        octave octave-signal gnuplot\
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER $NB_UID

RUN mamba install -y --quiet octave_kernel=0.32.0 \
    && conda clean --all

RUN jupyter lab build

ENV KERNEL_LANGUAGE python
CMD /usr/local/bin/bootstrap-kernel.sh
