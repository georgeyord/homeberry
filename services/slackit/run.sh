#! /bin/bash

SLACKIT_LOG_PATH="/tmp/slackit.log"
SLACKIT_HOSTNAME="$(hostname)"
SLACKIT_IPS="$(hostname -I)"
MESSAGE="RaspberryPi '${SLACKIT_HOSTNAME}' has booted!
IPs:
${SLACKIT_IPS}
Local network config:
$(/sbin/ifconfig)
"

touch "${SLACKIT_LOG_PATH}"

if [ -z "${SLACKIT_URL}" ]; then
  echo -e "FAILED $(date) Env variable SLACKIT_URL is missing" >> "${SLACKIT_LOG_PATH}"
  exit 1
fi

SLACKIT_LOG_FIRST_LINE=$(head -n 1 "${SLACKIT_LOG_PATH}")
SLACKIT_LOG_IPS=$(head -n 5 "${SLACKIT_LOG_PATH}" | tail -n 1)

if  [[ "OK" != "${SLACKIT_LOG_FIRST_LINE}" ]] ||
    [[ "${SLACKIT_LOG_IPS}" != "${SLACKIT_IPS}" ]]; then
  curl  -X POST \
        -s \
        -H 'Content-type: application/json' \
        --data "{\"text\":\"${MESSAGE}\"}" \
        "${SLACKIT_URL}" \
    && \
    echo -e "OK\n$(date)\n${MESSAGE}" > "${SLACKIT_LOG_PATH}" || \
    echo -e "FAILED $(date)" >> "${SLACKIT_LOG_PATH}"
else
  echo -e "ALREADY SENT $(date)" >> "${SLACKIT_LOG_PATH}"
fi
