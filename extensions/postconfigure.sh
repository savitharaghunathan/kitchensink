#!/usr/bin/env bash
echo ">>>>>> Executing postconfigure.sh <<<<<<<"

if [ "${SCRIPT_DEBUG}" = "true" ] ; then
    set -x
    echo "Script debugging is enabled, allowing bash commands and their arguments to be printed as they are executed"
fi

echo "Appending CLI operations to ${CLI_SCRIPT_FILE}"

echo "
  /subsystem=datasources/data-source=database_server-DATABASE_SERVER:write-attribute(name=pool-use-strict-min, value=true)
  /subsystem=datasources/data-source=database_server-DATABASE_SERVER:write-attribute(name=idle-timeout-minutes, value=5)
" >> "${CLI_SCRIPT_FILE}"

