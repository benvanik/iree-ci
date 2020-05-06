FROM iree-ci/build-host-linux-clang-10:latest
USER root

RUN set -xe && \
  apt-get update && \
  apt-get install -y \
      distcc \
      distcc-pump && \
  \
  rm -rf /var/lib/apt/lists/*

RUN useradd --create-home -s /bin/bash distcc
USER distcc
ENV \
  DEBIAN_FRONTEND=noninteractive \
  HOME=/home/distcc

# DISTCC_OPS_PORT
# DISTCC_STATS_PORT
ENTRYPOINT [ \
  "/usr/bin/distccd", \
  "--no-detach", \
  "--daemon", \
  "--log-level", "info", \
  "--log-stderr", \
  "--listen", "0.0.0.0", \
  "--port", "27100", \
  "--stats", \
  "--stats-port", "27101", \
  "--verbose" \
]

# Defaults:
CMD [ \
  "--allow", "0.0.0.0/0", \
  "--nice", "5", \
  "--jobs", "5" \
]

# https://docs.docker.com/engine/reference/builder/#healthcheck
HEALTHCHECK --interval=5m --timeout=3s \
  CMD curl -f http://0.0.0.0:27101/ || exit 1
