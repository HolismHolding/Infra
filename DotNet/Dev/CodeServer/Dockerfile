FROM ubuntu:latest

RUN apt update && apt install curl -y

RUN curl -fsSL https://code-server.dev/install.sh | sh

RUN apt install libcap2-bin -y

RUN apt install systemd -y