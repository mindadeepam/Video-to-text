ARG BASE_IMAGE=ubuntu:22.04
FROM $BASE_IMAGE
ENV DEBIAN_FRONTEND=noninteractive       
WORKDIR /app/

# ENV USER non_root
# ENV HOME /home/${USER}
# WORKDIR ${HOME}/

COPY setup.sh setup.sh
COPY requirements.txt requirements.txt
RUN apt-get install -y sudo && apt-get update

# RUN groupadd -r user && useradd -r -m -g user ${USER} \
#     && apt-get update \
#     && apt-get install -y sudo
# RUN echo "${USER}:root" | chpasswd
# USER ${USER}

CMD ["/bin/bash"]
