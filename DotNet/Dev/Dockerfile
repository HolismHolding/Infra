FROM mcr.microsoft.com/vscode/devcontainers/dotnetcore:0-3.1
    
RUN dotnet tool install --global dotnet-ef --version 3.1.12

ENV PATH="${PATH}:/root/.dotnet/tools:/HolismHolding/Infra/DotNet/Dev"  

RUN mkdir /HolismDotNet \
    && chmod 777 /HolismDotNet \
    && cd /HolismDotNet/ \
    && git clone https://github.com/HolismDotNet/Framework \
    && cd /HolismDotNet/Framework \
    && dotnet build

# https://github.com/dotnet/dotnet-docker/blob/main/samples/dotnetapp/Dockerfile

# Todo: R&D about docker URL context
# https://docs.docker.com/engine/reference/builder/#usage

# Can I use git submodules and direct git cloning on each "image" to reduce dependency on the infra? Developer just clones "X" and runs "./Setup.sh". Then this happens:
# docker command fetchs a Dockerfile from github
# docker command builds an image from .NET SDK
# docker builds a SQL Server Express container
# docker gets Framework, Quality, Api, WebUi, and any other required dependency (or maybe I should publish Framework, Quality, Api, WebUi, etc to NuGet; or even publish only with one version => replace=true)

# https://docs.docker.com/glossary/

# https://docs.microsoft.com/en-us/windows-server/get-started/getting-started-with-nano-server

# docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=developer' -e 'MSSQL_PID=Express' -p 1433:1433 -d mcr.microsoft.com/mssql/server:2019-latest-ubuntu