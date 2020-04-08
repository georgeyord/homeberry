#! /bin/bash

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")
cd "${SCRIPT_DIR}"

LOG_PATH="/var/log/aconnect-in-out.log"
touch "${LOG_PATH}"

test -z "${ACONNECT_INPUT_LABEL}" && echo -e "FAILED $(date) ACONNECT_INPUT_LABEL is empty" >> "${LOG_PATH}" && exit 1
test -z "${ACONNECT_OUTPUT_LABEL}" && echo -e "FAILED $(date) ACONNECT_OUTPUT_LABEL is empty" >> "${LOG_PATH}" && exit 1

ACONNECT_INPUT_ID="$(./aconnect-find-client-id-from-label.sh ${ACONNECT_INPUT_LABEL})"
test -z "${ACONNECT_INPUT_ID}" && echo -e "FAILED $(date) ACONNECT_INPUT_ID is empty" >> "${LOG_PATH}" && exit 1
ACONNECT_OUTPUT_ID="$(./aconnect-find-client-id-from-label.sh ${ACONNECT_OUTPUT_LABEL})"
test -z "${ACONNECT_OUTPUT_ID}" && echo -e "FAILED $(date) ACONNECT_OUTPUT_ID is empty" >> "${LOG_PATH}" && exit 1

OUTPUT="$(aconnect ${ACONNECT_INPUT_ID} ${ACONNECT_OUTPUT_ID})"
RESULT=$?

if [ "${RESULT}" -eq 0 ]; then
  export MESSAGE="MIDI connected: ${ACONNECT_INPUT_LABEL}(${ACONNECT_INPUT_ID}) -> ${ACONNECT_OUTPUT_LABEL}(${ACONNECT_OUTPUT_ID})"
  # slackit pushes MESSAGE env variable
  test -f "${SLACKIT_PATH}" && "${SLACKIT_PATH}"
  echo "OK $(date) ${MESSAGE}" >> "${LOG_PATH}"
elif [[ "${OUTPUT}" == *"Connection is already subscribed"* ]]; then
  echo -e "PASS $(date) ${OUTPUT}" >> "${LOG_PATH}"
elif [[ "${OUTPUT}" == *"Connection failed"* ]]; then
  echo -e "FAIL $(date) ${OUTPUT}" >> "${LOG_PATH}"
fi
