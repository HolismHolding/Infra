FROM mcr.microsoft.com/dotnet/sdk:6.0
    
RUN dotnet tool install --global dotnet-ef --version 6.0.0

ENV PATH="${PATH}:/root/.dotnet/tools:/HolismHolding/Infra/DotNet/Dev"  

RUN mkdir /HolismDotNet \
    && chmod 777 /HolismDotNet \
    && cd /HolismDotNet/ \
    && git clone https://github.com/HolismDotNet/Infra \
    && cd /HolismDotNet/Infra \
    && dotnet build