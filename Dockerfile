FROM ubuntu:16.04
RUN apt-get update && apt-get install -y python-neutronclient python-novaclient python-keystoneclient python-netaddr python-cinderclient python-prometheus-client
RUN mkdir -p /var/cache/prometheus-openstack-exporter/ && mkdir -p /etc/prometheus-openstack-exporter

EXPOSE 9183

COPY ./prometheus-openstack-exporter /
COPY ./entrypoint.sh /
COPY ./default.yaml /

CMD ["/entrypoint.sh"]
