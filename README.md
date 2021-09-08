# About

Easily start IoT Hub simulators using DTDL / Azure IoT Plug & Play models.

This project generates a Docker Image from the excellent Azure IoT Device Simulator [jonmikeli/azureiotdevicesimulator5-pnp](https://github.com/jonmikeli/azureiotdevicesimulator5-pnp).
It provides a simple way to start the simulator with default settings. You are only required you to provide a Connection String and a DTDL model.

You can find official DTDL models [here](https://github.com/Azure/iot-plugandplay-models/tree/main/dtmi).

DTDL v2 is defined [here](https://github.com/Azure/opendigitaltwins-dtdl/blob/master/DTDL/v2/dtdlv2.md).

If you need more advanced settings, please check out @jonmikeli's repo linked above.

## Usage

```console
docker run --rm -ti \
  -e IOT_HUB_CONNECTION_STRING="HostName=iothub-x.azure-devices.net;DeviceId=simulated-device;SharedAccessKey=y" \
  -e MODEL_URL="https://raw.githubusercontent.com/Azure/opendigitaltwins-dtdl/master/DTDL/v2/samples/Thermostat.json" \
  ghcr.io/stefan-hudelmaier/iot-pnp-simple-simulator:main
```

Environment Variables:

| Variable                     | Description         |
| -----------------------------|---------------|
| IOT_HUB_CONNECTION_STRING    | The connection string of the IoT Hub device to be simulated |
| MODEL_URL                    | The URL to a IoT Plug & Play model in DTDL format. When using a model from GitHub, remember to use the 'raw' link.


As soon as you have started the container, you should see telemetry values being sent:

```
09/08/2021 16:46:29::logType:data::simulated-device::Sent message: [
  {
    "temperature": 0.014509523294172027
  }
].
```

The simulator can also handle direct methods defined in the DTDL. Invoking the `getMaxMinReport` direct method defined in 
[Thermostat.json](https://raw.githubusercontent.com/Azure/opendigitaltwins-dtdl/master/DTDL/v2/samples/Thermostat.json) (that was used in the example above) results in the following output and response:

```
dbug: IoT.Simulator.Services.DeviceSimulationService[0]
      09/08/2021 13:56:07::logType:c2ddirectmethods.dtdlcommand.handler::DTDL Command called: getMaxMinReport with payload {}.
dbug: IoT.Simulator.Services.DeviceSimulationService[0]
      09/08/2021 13:56:07::logType:c2ddirectmethods.dtdlcommand.handler::DTDL Command response: {
        "request": {
          "since": "2021-09-13T17:53:02.6077651+00:00"
        },
        "response": {
          "tempReport": {
            "maxTemp": 0.9224262367572758,
            "minTemp": 0.05373290928720166,
            "avgTemp": 0.11802005680185745,
            "startTime": "2021-09-10T03:53:02.6546508+00:00",
            "endTime": "2021-09-08T15:53:02.6552922+00:00"
          }
        }
      } to request {}.
```
