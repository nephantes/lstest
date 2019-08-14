FROM nfcore/base
LABEL author="alper.kucukural@umassmed.edu" description="Docker image containing all requirements for the dolphinnext/lstest pipeline"

COPY environment.yml /
RUN conda env create -f /environment.yml && conda clean -a
