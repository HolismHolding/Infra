ARG VARIANT="6.0-bullseye-slim"
FROM mcr.microsoft.com/vscode/devcontainers/dotnet:${VARIANT}
    
ENV PATH="${PATH}:/HolismHolding/Infra/DotNet/Dev"

ENV Nuget=/root/.local/share/NuGet/v3-cache/

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
RUN apt-get update && apt-get install -y apt-utils libgdiplus libc6-dev