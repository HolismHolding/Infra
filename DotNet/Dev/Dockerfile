ARG VARIANT="6.0-bullseye-slim"
FROM mcr.microsoft.com/vscode/devcontainers/dotnet:0-${VARIANT}
    
ENV PATH="${PATH}:/HolismHolding/Infra/DotNet/Dev"

ENV Nuget=/root/.local/share/NuGet/v3-cache/670c1461c29885f9aa22c281d8b7da90845b38e4$ps:_api.nuget.org_v3_index.json/

RUN mkdir /HolismDotNet
RUN chmod 777 /HolismDotNet
WORKDIR /HolismDotNet
RUN git clone https://github.com/HolismDotNet/Infra
WORKDIR /Temp
RUN dotnet new console
RUN echo '<Project Sdk="Microsoft.NET.Sdk.Web"><Import Project="/HolismDotNet/Infra/DotNet.targets" /></Project>' > /Temp/Temp.csproj
RUN echo 'System.Console.WriteLine("hello");' > /Temp/Program.cs
RUN dotnet restore
RUN dotnet build
WORKDIR /
RUN rm -rf /Temp

RUN apt update
RUN apt install -y procps
RUN apt install gettext-base