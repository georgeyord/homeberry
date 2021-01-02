#! /bin/bash

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")
cd "${SCRIPT_DIR}"

ONBOOT_LOG_PATH="/tmp/slackit-onboot.log"
touch "${ONBOOT_LOG_PATH}"

ONBOOT_HOSTNAME="$(hostname)"
ONBOOT_IPS="$(hostname -I)"
export MESSAGE="RaspberryPi '${ONBOOT_HOSTNAME}' got an IP!
IPs:
${ONBOOT_IPS}
"
# Local network config:
# $(/sbin/ifconfig)

ONBOOT_LOG_FIRST_LINE=$(head -n 1 "${ONBOOT_LOG_PATH}")
ONBOOT_LOG_IPS=$(head -n 5 "${ONBOOT_LOG_PATH}" | tail -n 1)

# Slackit pushes MESSAGE env variable
if [[ "OK" != "${ONBOOT_LOG_FIRST_LINE}" ]]; then
  ./slackit.sh && \
  echo -e "OK\nSent on $(date)\n${MESSAGE}" > "${ONBOOT_LOG_PATH}" || \
  echo -e "FAILED $(date)" >> "${ONBOOT_LOG_PATH}"
elif [[ "${ONBOOT_LOG_IPS}" != "${ONBOOT_IPS}" ]]; then
  ./slackit.sh && \
  echo -e "OK\nIP changed on $(date)\n${MESSAGE}" > "${ONBOOT_LOG_PATH}" || \
  echo -e "FAILED $(date)" >> "${ONBOOT_LOG_PATH}"
else
  echo -e "ALREADY SENT $(date)" >> "${ONBOOT_LOG_PATH}"
fi
