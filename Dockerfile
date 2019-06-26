FROM debian:stretch

LABEL lework="lework <lework@yeah.net>"

ENV \
  TZ='Asia/Shanghai' \
  COMPILER=dmd \
  COMPILER_VERSION=2.085.0


RUN apt-get update -y \
  && apt-get install -y tzdata curl libcurl3 build-essential \
  && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
  && echo ${TZ} > /etc/timezone \
  && curl -fsS -o /tmp/install.sh https://dlang.org/install.sh \
  && bash /tmp/install.sh -p /dlang install "${COMPILER}-${COMPILER_VERSION}" \
  && apt-get install -y gcc libmemcached-dev libpq-dev libmagickcore-6.q16-3 openssl libnss3 psmisc default-libmysqlclient-dev \
  && rm /tmp/install.sh \
  && rm -rf /var/cache/apt \
  && rm -rf /dlang/${COMPILER}-*/linux/bin32 \
  && rm -rf /dlang/${COMPILER}-*/linux/lib32 \
  && rm -rf /dlang/${COMPILER}-*/html


ENV \
  PATH=/dlang/dub:/dlang/${COMPILER}-${COMPILER_VERSION}/linux/bin64:${PATH} \
  LD_LIBRARY_PATH=/dlang/${COMPILER}-${COMPILER_VERSION}/linux/lib64 \
  LIBRARY_PATH=/dlang/${COMPILER}-${COMPILER_VERSION}/linux/lib64 \
  PS1="(${COMPILER}-${COMPILER_VERSION}) \\u@\\h:\\w\$"
  
WORKDIR /src

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["bash"]