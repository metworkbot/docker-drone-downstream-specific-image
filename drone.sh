#!/bin/bash

if test "${PLUGIN_REPOSITORIES:-}" = ""; then
  echo "missing PLUGIN_REPOSITORIES env var"
  echo "=> miss repositories value in configuration ?"
  exit 1
fi
if test "${DRONE_SERVER:-}" = ""; then
  echo "missing DRONE_SERVER env var"
  echo "=> miss drone_server secret in configuration ?"
  exit 1
fi
if test "${DRONE_TOKEN:-}" = ""; then
  echo "missing DRONE_TOKEN env var"
  echo "=> miss drone_server secret in configuration ?"
  exit 1
fi

if test -f .drone_downstream_bypass; then
    echo "downstream bypass"
    exit 0
fi

for REPO in $(echo "${PLUGIN_REPOSITORIES}" |sed 's/,/ /g'); do
    REPO_NAME=$(echo "${REPO}" |awk -F '@' '{print $1;}')
    BRANCH_NAME=$(echo "${REPO}" |awk -F '@' '{print $2;}')
    if test "${BRANCH_NAME:-}" = ""; then
        BRANCH_NAME=master
    fi
    echo "Working on REPO_NAME=${REPO_NAME} and BRANCH=${BRANCH_NAME}..."
    LAST=$(drone build last --branch="${BRANCH_NAME}" "${REPO_NAME}")
    if test $? -ne 0; then
        echo "can't find last build for repo:${REPO_NAME} and branch:${BRANCH_NAME}"
        exit 1
    fi
    LAST_BUILD=$(echo "${LAST}" |head -1 |awk '{print $2;}')
    if test "${LAST_BUILD}" = ""; then
        echo "can't find last build for repo:${REPO_NAME} and branch:${BRANCH_NAME}"
        echo "raw last output: ${LAST}"
        exit 1
    fi
    echo "Last build: ${LAST_BUILD}"
    PARAM_ARGS=""
    if test "${PLUGIN_PARAMS}" != ""; then
        for PARAM in $(echo "${PLUGIN_PARAMS}" |sed 's/,/ /g'); do
            PARAM_ARGS="--param ${PARAM} ${PARAM_ARGS}"
        done
    fi
    echo "Restarting build ${LAST_BUILD} with param args: ${PARAM_ARGS}"
    drone build start ${PARAM_ARGS} ${REPO_NAME} ${LAST_BUILD}
    if test $? -ne 0; then
        echo "ERROR during drone build start"
        exit 1
    fi
done
