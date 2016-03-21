FROM toopher/ubuntu-i386:12.04

MAINTAINER Nicola Corti "corti.nico@gmail.com"

LABEL name=java8-32bit
LABEL version=1


# Disable interactive package setup
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Install Java.
RUN \
#  apt-get install -y dialog && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 437D05B5 3E5C1192  && \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  apt-get update && \
  apt-get install -y python-software-properties && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

# Define working directory.
WORKDIR /data

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Define default command.
CMD ["bash"]
