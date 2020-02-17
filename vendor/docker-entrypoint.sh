#!/bin/bash
set -e
unset BUNDLE_PATH
unset BUNDLE_BIN
exec "$@"
