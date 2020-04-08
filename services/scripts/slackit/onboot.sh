#! /bin/bash

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")
cd "${SCRIPT_DIR}"

ONBOOT_LOG_PATH="/tmp/slackit-onboot.log"
touch "${ONBOOT_LOG_PATH}"

ONBOOT_HOSTNAME="$(hostname)"
ONBOOT_IPS="$(hostname -I)"
export MESSAGE="RaspberryPi '${ONBOOT_HOSTNAME}' has booted!
IPs:
${ONBOOT_IPS}
"
# Local network config:
# $(/sbin/ifconfig)

ONBOOT_LOG_FIRST_LINE=$(head -n 1 "${ONBOOT_LOG_PATH}")
ONBOOT_LOG_IPS=$(head -n 5 "${ONBOOT_LOG_PATH}" | tail -n 1)

if  [[ "OK" != "${ONBOOT_LOG_FIRST_LINE}" ]] ||
    [[ "${ONBOOT_LOG_IPS}" != "${ONBOOT_IPS}" ]]; then
  # Slackit pushes MESSAGE env variable
  ./slackit.sh && \
  echo -e "OK\n$(date)\n${MESSAGE}" > "${ONBOOT_LOG_PATH}" || \
  echo -e "FAILED $(date)" >> "${ONBOOT_LOG_PATH}"
else
  echo -e "ALREADY SENT $(date)" >> "${ONBOOT_LOG_PATH}"
fi
