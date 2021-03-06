FROM dboxx/systemd:v241.7

# GlusterFS configuration
ENV GFS_VERSION="8"
ENV GFS_RELEASE="${GFS_VERSION}.3"

# GlusterFS APT configuration
ENV GFS_APT_URL="https://download.gluster.org/pub/gluster/glusterfs"
ENV GFS_APT_KEY="${GFS_APT_URL}/${GFS_VERSION}/rsa.pub"
ENV GFS_APT_SRC="${GFS_APT_URL}/${GFS_VERSION}/${GFS_RELEASE}/Debian/${DEBIAN_VERSION_NAME}/amd64/apt"

ENV DEBIAN_FRONTEND="noninteractive"

RUN curl -sSk "${GFS_APT_KEY}" | apt-key add - \
 && echo "deb [arch=amd64] ${GFS_APT_SRC} ${DEBIAN_VERSION_NAME} main" > /etc/apt/sources.list.d/gluster.list \
 && cat /etc/apt/sources.list.d/gluster.list \
 && apt-get update -y \
 && apt-get install -yy \
      glusterfs-common \
      glusterfs-server \
      glusterfs-client \
 && apt-get autoremove -y --purge \
 && apt-get autoclean -y \
 && apt-get clean -y \
 && apt-get check -y \
 && rm -rf /var/lib/apt/lists/* /var/cache/* /usr/src/* /tmp/* /var/tmp/*

ENV DEBIAN_FRONTEND=""

RUN systemctl enable glusterd

WORKDIR $HOME
