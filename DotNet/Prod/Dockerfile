FROM holism/dotnet-dev:latest
RUN mkdir /Temp
COPY . .
RUN cd ${RepositoryPath} \
    && rm -rf bin \
    && rm -rf obj \
    && dotnet publish Api -o /Temp/Publish

FROM mcr.microsoft.com/dotnet/aspnet:6.0
COPY --from=0 /Temp/Publish /${RepositoryPath}
WORKDIR ${RepositoryPath}
RUN rm -rf ConnectionStrings.json \
    && rm -rf Settings.json \
    && rm -rf SettingsOverride.json
CMD [ "dotnet", "${Organization}.${Repository}.dll" ]