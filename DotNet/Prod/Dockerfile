FROM holism/dotnet-dev:latest
RUN mkdir /Temp
COPY . .
RUN cd ${RepositoryPath} \
    && rm -rf bin \
    && rm -rf obj \
    && dotnet publish Api -o /Temp/Publish

FROM mcr.microsoft.com/dotnet/aspnet:6.0
RUN apt-get update && apt-get install -y apt-utils libgdiplus libc6-dev
RUN apt update
RUN apt install -y procps
COPY --from=0 /Temp/Publish /${RepositoryPath}
WORKDIR ${RepositoryPath}
RUN rm -rf ConnectionStrings.json \
    && rm -rf Settings.json \
    && rm -rf SettingsOverride.json
RUN echo alias Kill="ps -ef | grep 'dotnet' | grep -v grep | awk '{print $2}' | xargs -r kill -9" >> ~/.bashrc
RUN echo alias Run="dotnet Api.dll" >> ~/.bashrc
CMD [ "dotnet", "Api.dll" ]
# todo: https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-run