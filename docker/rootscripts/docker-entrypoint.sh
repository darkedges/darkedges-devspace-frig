#!/usr/bin/env bash

INSTANCE_DIR="${INSTANCE_DIR:-${HOME}/.openig}"
env_file="${INSTANCE_DIR}/bin/env.sh"
if [ -r "${env_file}" ]; then
    . "${env_file}"
fi

start() {
    echo "Starting FRIG"
    set -ex
    exec tini -v -- ${JAVA_HOME}/bin/java -classpath "classes:lib/*:${INSTANCE_DIR}/extra/*" ${JAVA_OPTS} org.forgerock.openig.launcher.Main ${INSTANCE_DIR}
}

devspace() {
    echo "Starting devspace-FRIG"
    set -ex
    ${JAVA_HOME}/bin/java -classpath "classes:lib/*:${INSTANCE_DIR}/extra/*" ${JAVA_OPTS} org.forgerock.openig.launcher.Main ${INSTANCE_DIR}
}

CMD="${1:-start}"

case "$CMD" in
devspace)
    devspace
    ;;
start)
    start
    ;;
*)
    exec "$@"
esac