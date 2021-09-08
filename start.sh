#!/bin/bash

set -e

#DEFAULT_MODEL_URL=https://raw.githubusercontent.com/Azure/iot-plugandplay-models/main/dtmi/azureiot/phonesensors-1.json
DEFAULT_MODEL_URL=https://raw.githubusercontent.com/Azure/opendigitaltwins-dtdl/master/DTDL/v2/samples/Thermostat.json

if [[ -z "${IOT_HUB_CONNECTION_STRING}" ]]; then
  echo "The environment variable IOT_HUB_CONNECTION_STRING is not set. Cannot continue. Please set IOT_HUB_CONNECTION_STRING to the connection string of your device in IoT Hub."
  exit 1
fi


if [[ -z "${MODEL_URL}" ]]; then
  echo "The environment variable MODEL_URL is not set, using '$DEFAULT_MODEL_URL' by default."
  MODEL_URL=$DEFAULT_MODEL_URL
fi

MODEL_ID=$(curl -s $MODEL_URL | jq '.["@id"]' | tr -d '"')

echo "Model ID: $MODEL_ID"

cp devicesettings.template.json devicesettings.Development.json

# It's difficult to replace arbitrary strings with sed, awk due to special character handling
python replace.py __MODEL_URL__ "${MODEL_URL}" devicesettings.Development.json
python replace.py __MODEL_ID__ "${MODEL_ID}" devicesettings.Development.json
python replace.py __IOT_HUB_CONNECTION_STRING__ "${IOT_HUB_CONNECTION_STRING}" devicesettings.Development.json

dotnet IoT.Simulator.dll
