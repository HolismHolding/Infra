#docker build -t holism/dotnet-debug:latest .
ARG VARIANT="3.1"
FROM mcr.microsoft.com/vscode/devcontainers/dotnetcore:0-${VARIANT}

RUN dotnet tool install --global dotnet-ef --version 3.1.12

ENV PATH="${PATH}:/root/.dotnet/tools:/HolismHolding/Infra/DotNet/Dev"  

RUN mkdir /HolismDotNet \
    && chmod 777 /HolismDotNet \
    && cd /HolismDotNet/ \
    && git clone https://github.com/HolismDotNet/Framework \
    && cd /HolismDotNet/Framework \
    && dotnet build