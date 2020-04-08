#! /bin/bash

SLACKIT_LOG_PATH="/var/log/slackit.log"
touch "${SLACKIT_LOG_PATH}"

if [ -z "${MESSAGE}" ]; then
  # >&2
  echo -e "FAILED $(date) Env variable MESSAGE is missing" >> "${SLACKIT_LOG_PATH}"
  exit 1
fi

if [ -z "${SLACKIT_URL}" ]; then
  echo -e "FAILED $(date) Env variable SLACKIT_URL is missing" >> "${SLACKIT_LOG_PATH}"
  exit 1
fi

curl  -X POST \
      -s \
      -H 'Content-type: application/json' \
      --data "{\"text\":\"${MESSAGE}\"}" \
      "${SLACKIT_URL}" \

RESULT=$?

test $? && \
echo -e "OK\n$(date)\n${MESSAGE}" >> "${SLACKIT_LOG_PATH}" || \
echo -e "FAILED $(date)" >> "${SLACKIT_LOG_PATH}"

exit "${RESULT}"
