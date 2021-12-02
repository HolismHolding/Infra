FROM mcr.microsoft.com/dotnet/sdk:6.0
    
ENV PATH="${PATH}:/HolismHolding/Infra/DotNet/Dev"  

RUN mkdir /HolismDotNet \
    && chmod 777 /HolismDotNet \
    && cd /HolismDotNet/ \
    && git clone https://github.com/HolismDotNet/Infra \
    && cd /HolismDotNet/Infra \
    && dotnet build