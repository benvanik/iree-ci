FROM iree-ci/build-host-linux:latest
USER root

RUN set -xe && \
  # LLVM/clang source repositories.
  wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
  echo "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-10 main" | tee -a /etc/apt/sources.list.d/clang.list && \
  echo "deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic-10 main" | tee -a /etc/apt/sources.list.d/clang.list && \
  \
  apt-get update && \
  apt-get install -y \
      clang-10 \
      clang++-10 \
      clang-tools-10 \
      clang-format-10 \
      libfuzzer-10-dev \
      lld-10 \
      libc++-10-dev \
      libc++abi-10-dev \
      && \
  rm -rf /var/lib/apt/lists/* && \
  update-alternatives --install /usr/bin/clang clang /usr/bin/clang-10 50 && \
  update-alternatives --install /usr/bin/cc cc /usr/bin/clang-10 50 && \
  update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++-10 50

USER builder

ENV \
  CC=cc \
  CXX=c++

RUN set -xe && \
  \
  mkdir -p $HOME/bin/ && \
  cd $HOME && \
  git clone https://github.com/mbitsnbites/buildcache.git && \
  cd $HOME/buildcache && \
  mkdir build && \
  cd build && \
  cmake -DCMAKE_BUILD_TYPE=Release ../src && \
  cmake --build . && \
  mv buildcache $HOME/bin/ && \
  cd $HOME && \
  rm -rf $HOME/buildcache

ENV \
  BUILDCACHE=/home/builder/buildcache/build/ \
  BUILDCACHE_REMOTE=redis://buildcache-redis:6379
