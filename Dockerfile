#
# Build an Ubuntu installation of gmsvtoolkit
#
from ubuntu:jammy
MAINTAINER Philip Maechling maechlin@usc.edu

# Define Build and runtime arguments
# These accept userid and groupid from the command line
#APP_UNAME = gmsvtoolkit
#APP_GRPNAME = scec
#APP_UID = 1000
#APP_GID = 20
#BDATE = 04262023

ENV APP_UNAME=gmsvtoolkit \
APP_GRPNAME=scec \
APP_UID=1000 \
APP_GID=20 \
BDATE=04262023

# Retrieve the userid and groupid from the args so 
# Define these parameters to support building and deploying on EC2 so user is not root
# and for building the model and adding the correct date into the label
RUN echo $APP_UNAME $APP_GRPNAME $APP_UID $APP_GID $BDATE

#
RUN apt-get -y update
RUN apt-get -y upgrade
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Los_Angeles

RUN apt-get install -y build-essential git vim nano python3 python3-pip

# Install latest gfortran and fftw
RUN apt-get install -y libfftw3-dev libfftw3-mpi-dev libopenmpi-dev gfortran
RUN pip3 install pandas notebook jupyterlab

RUN ln -s /usr/bin/python3 /usr/bin/python

# Setup Owners
# Group add duplicates "staff" so just continue if it doesn't work
RUN groupadd -f --non-unique --gid $APP_GID $APP_GRPNAME
RUN useradd -ms /bin/bash -G $APP_GRPNAME --uid $APP_UID $APP_UNAME

#Define interactive user
USER $APP_UNAME

# Move to the user directory where the gmsvtoolkit is installed and built
WORKDIR /home/$APP_UNAME
RUN git clone https://github.com/pjmaechling/gmsvtoolkit.git

WORKDIR /home/$APP_UNAME/gmsvtoolkit/gmsvtoolkit/src
RUN make -f makefile

# Setup GMSVtoolkit path
ENV PYTHONPATH="$PYTHONPATH:/home/$APP_UNAME/gmsvtoolkit/gmsvtoolkit"
ENV PATH="$PATH:/home/$APP_UNAME/gmsvtoolkit/gmsvtoolkit/src/gp/bin:/home/$APP_UNAME/gmsvtoolkit/gmsvtoolkit/src/ucb/bin:/home/$APP_UNAME/gmsvtoolkit/gmsvtoolkit/src/usgs/bin"
ENV GMSVTOOLKIT_DIR="/home/$APP_UNAME/gmsvtoolkit/gmsvtoolkit"


# Define file input/output mounted disk
#
VOLUME /home/$APP_UNAME/gmsvtoolkit/tutorial
WORKDIR /home/$APP_UNAME/gmsvtoolkit/tutorial
#
# The .bashrc and .bash_profile will Define ENV variables
#
#
# Add metadata to dockerfile using labels
LABEL "org.scec.project"="GMSVToolkit"
LABEL org.scec.responsible_person="Fabio Silva"
LABEL org.scec.primary_contact="fsilv@usc.edu"
LABEL version="$BDATE"


#Create interactive entry point
#ENTRYPOINT ["/usr/bin/jupyter","notebook","--ip=0.0.0.0","--notebook-dir=/home/gtkuser/target","--allow-root","--no-browser"]
#CMD ["/bin/bash"]
