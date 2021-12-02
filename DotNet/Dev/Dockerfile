FROM mcr.microsoft.com/dotnet/sdk:6.0
    
ENV PATH="${PATH}:/HolismHolding/Infra/DotNet/Dev"

ENV Nuget=/root/.local/share/NuGet/v3-cache/670c1461c29885f9aa22c281d8b7da90845b38e4$ps:_api.nuget.org_v3_index.json/

RUN mkdir /HolismDotNet \
    && chmod 777 /HolismDotNet \
    && cd /HolismDotNet/ \
    && git clone https://github.com/HolismDotNet/Infra \
    && cd /HolismDotNet/Infra \
    && dotnet build