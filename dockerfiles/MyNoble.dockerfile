FROM ubuntu:noble

RUN apt update && \
  apt install -y git openssh-client vim sudo curl wget net-tools iputils-ping && \
  rm -rf /var/lib/apt/lists/*

RUN groupadd -g 10001 bob && \
  useradd -u 10001 -s /bin/bash -m -g bob bob && \
  usermod -aG sudo bob

USER bob

WORKDIR /home/bob

RUN mkdir -p .ssh test

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash && \
  bash -c "source ~/.nvm/nvm.sh && nvm install 24 && nvm alias default 24"

CMD ["bash", "-c", "eval $(ssh-agent -s) && exec bash"]