#!/bin/sh

set -e

cd "$(dirname "$0")/.."


# validate env

. ./.env

if [ -z "$SERVER_LICENSE_KEY" ]; then
    echo "SERVER_LICENSE_KEY is not set"
    exit 1
fi


# init
cleanup() {
    rm -rf tmp
}
trap 'cleanup' INT TERM EXIT
cleanup
mkdir -p tmp

# FXServer runtime (Bandizip window appears, you should close it manually)
rm -rf artifacts
curl -o tmp/server.7z https://runtime.fivem.net/artifacts/fivem/build_server_windows/master/17000-e0ef7490f76a24505b8bac7065df2b7075e610ba/server.7z
mkdir artifacts
powershell.exe -Command "Bandizip.exe x tmp\\server.7z artifacts" # spawn process, you should close its window manually

# resources
rm -rf resources
mkdir -p resources
curl -Lo tmp/fivem-appearance.rar https://github.com/pedr0fontoura/fivem-appearance/releases/download/v1.3.1/fivem-appearance.rar
powershell.exe -Command "Bandizip.exe x tmp\\fivem-appearance.rar resources" # spawn process, you should close its window manually
cp -r "templates/[debug]" "templates/main" "resources"
git clone https://github.com/citizenfx/cfx-server-data.git tmp/cfx-server-data
cp -r tmp/cfx-server-data/resources "resources/[cfx-default]"

# server.cfg
cat templates/server.cfg | sed "s#\[\[SERVER_LICENSE_KEY\]\]#$SERVER_LICENSE_KEY#g" > server.cfg
