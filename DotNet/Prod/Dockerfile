FROM holism/dotnet-dev:latest
ARG Path
RUN mkdir /Temp
COPY . .
RUN cd "${Path}" \
    && dotnet publish Api -o /Temp/Publish

FROM mcr.microsoft.com/dotnet/aspnet:3.1
COPY --from=0 /Temp/Publish /DotNetApi