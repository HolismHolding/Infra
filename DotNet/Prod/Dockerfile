FROM holism/dotnet-dev:latest
RUN mkdir /Temp
COPY . .
RUN cd ${RepositoryPath} \
    && dotnet publish Api -o /Temp/Publish

FROM mcr.microsoft.com/dotnet/aspnet:3.1
COPY --from=0 /Temp/Publish /${RepositoryPath}
WORKDIR ${RepositoryPath}
CMD [ "dotnet", "${Organization}.${Repository}.Api.dll" ]