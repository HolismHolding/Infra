FROM mcr.microsoft.com/dotnet/sdk:3.1
    
RUN dotnet tool install --global dotnet-ef --version 3.1.12

ENV PATH="${PATH}:/root/.dotnet/tools:/HolismHolding/Infra/DotNet/Dev"  

RUN mkdir /HolismDotNet \
    && chmod 777 /HolismDotNet \
    && cd /HolismDotNet/ \
    && git clone https://github.com/HolismDotNet/Framework \
    && cd /HolismDotNet/Framework \
    && dotnet build