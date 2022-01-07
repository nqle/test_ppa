# nexus-oss service to host repositories is useful for .deb artifacts. 

FROM ubuntu:focal

RUN apt update && apt install -y openjdk-8-jre-headless nano wget curl gnupg
RUN wget -qO- https://download.sonatype.com/nexus/3/latest-unix.tar.gz | tar -xz --directory=/tmp
RUN echo "#!/bin/sh \n/tmp/nexus-3.37.3-02/bin/nexus start && tail -f /dev/null" > /tmp/nexus_start.sh && chmod +x /tmp/nexus_start.sh 
ENTRYPOINT ["/tmp/nexus_start.sh"]
