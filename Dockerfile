FROM microsoft/dotnet:2.1-sdk AS build-env
WORKDIR /app
COPY *.csproj ./
RUN dotnet restore
COPY . ./
RUN dotnet publish -c Release -o output

FROM microsoft/dotnet:2.1.5-aspnetcore-runtime
WORKDIR /app
COPY --from=build-env /app/output .
ENTRYPOINT ["dotnet", "Letskube.dll"]
