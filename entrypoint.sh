#!/bin/bash

CLOUD_NAME="${CLOUD_NAME:-mycloud}"
LISTEN_PORT="${LISTEN_PORT:-9183}"
CACHE_REFRESH_INTERVAL="${CACHE_REFRESH_INTERVAL:-300}"
CPU_ALLOCATION_RATIO="${CPU_ALLOCATION_RATIO:-2.5}"
RAM_ALLOCATION_RATIO="${RAM_ALLOCATION_RATIO:-1.1}"
DISK_ALLOCATION_RATIO="${DISK_ALLOCATION_RATIO:-1.0}"
RAM="${RAM:-4096}"
VCPU="${VCPU:-2}"
DISK="${DISK:-20}"

export OS_PROJECT_DOMAIN_NAME="${OS_PROJECT_DOMAIN_NAME:-default}"
export OS_USER_DOMAIN_NAME="${OS_USER_DOMAIN_NAME:-default}"
export OS_PROJECT_NAME="${OS_PROJECT_NAME:-admin}"
export OS_USERNAME="${OS_USERNAME:-admin}"
export OS_PASSWORD="${OS_PASSWORD:-password}"
export OS_AUTH_URL="${OS_AUTH_URL:-http://controller:35357/v3}"
export OS_IDENTITY_API_VERSION="${OS_IDENTITY_API_VERSION:-3}"
export OS_IMAGE_API_VERSION="${OS_IMAGE_API_VERSION:-2}"

k8s_configmap=$(mount | grep prometheus-openstack-exporter.yaml | wc -l)

if [ "$k8s_configmap" = 0 ]; then
  sed -i 's/<YAML_cloud_name>/'$CLOUD_NAME'/' /default.yaml
  sed -i 's/<YAML_listen_port>/'$LISTEN_PORT'/' /default.yaml
  sed -i 's/<YAML_cache_refresh_interval>/'$CACHE_REFRESH_INTERVAL'/' /default.yaml
  sed -i 's/<YAML_cpu_allocation_ratio>/'$CPU_ALLOCATION_RATIO'/' /default.yaml
  sed -i 's/<YAML_ram_allocation_ratio>/'$RAM_ALLOCATION_RATIO'/' /default.yaml
  sed -i 's/<YAML_disk_allocation_ratio>/'$DISK_ALLOCATION_RATIO'/' /default.yaml 
  sed -i 's/<YAML_ram_mbs>/'$RAM'/' /default.yaml
  sed -i 's/<YAML_vcpu>/'$VCPU'/' /default.yaml
  sed -i 's/<YAML_disk_gbs>/'$DISK'/' /default.yaml
  cp /default.yaml /etc/prometheus-openstack-exporter/prometheus-openstack-exporter.yaml
fi

./prometheus-openstack-exporter /etc/prometheus-openstack-exporter/prometheus-openstack-exporter.yaml

