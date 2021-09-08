## About

This generates a Docker Image from the excellent [jonmikeli/azureiotdevicesimulator5-pnp](https://github.com/jonmikeli/azureiotdevicesimulator5-pnp). 
It provides a simple way to start the simulator with default settings. You are only required you to provide a Connection String and a DTDL model. 

## Usage

```
docker run --rm -ti \
  -e IOT_HUB_CONNECTION_STRING="HostName=iothub-x.azure-devices.net;DeviceId=simulated-device;SharedAccessKey=y" \
  -e MODEL_URL="https://raw.githubusercontent.com/Azure/opendigitaltwins-dtdl/master/DTDL/v2/samples/Thermostat.json" \
  test
```
