FROM azureiotdevicesimulator5-pnp:latest

# python is only required for templating, which is a bit stupid. This should be done
# in a different way, e.g. using perl which is installed anyway.
RUN apt update && apt install -y curl jq python

COPY start.sh start.sh
COPY devicesettings.template.json devicesettings.template.json
COPY modulesettings.json modulesettings.Development.json
COPY appsettings.json appsettings.Development.json
COPY replace.py replace.py

CMD ["./start.sh"]
