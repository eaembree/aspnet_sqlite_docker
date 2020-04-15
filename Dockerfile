ARG VERSION=3.1-alpine3.11

# https://hub.docker.com/_/microsoft-dotnet-core
FROM mcr.microsoft.com/dotnet/core/sdk:$VERSION AS build
#WORKDIR /source

# copy csproj and restore as distinct layers
#COPY *.sln .
#COPY MvcMovie/*.csproj ./MvcMovie/
#RUN dotnet restore

# copy everything else and build app
#COPY MvcMovie/. ./MvcMovie/
#WORKDIR /source/MvcMovie
#RUN dotnet publish -c release -o /app

WORKDIR /source
COPY *.sln .
COPY MvcMovie/. ./MvcMovie
WORKDIR /source/MvcMovie
RUN dotnet publish -c release -o /app

# final stage/image
FROM mcr.microsoft.com/dotnet/core/aspnet:$VERSION
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT ["dotnet", "MvcMovie.dll"]
