FROM node:14-buster-slim

LABEL version="0.1"
LABEL repository="https://github.com/scutLMG/hexo-action"
LABEL maintainer="scutLMG <1392327780@qq.com>"

COPY entrypoint.sh /entrypoint.sh
COPY sync_deploy_history.js /sync_deploy_history.js

RUN apt-get update > /dev/null && \
    apt-get install -y git openssh-client > /dev/null ; \
    chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]