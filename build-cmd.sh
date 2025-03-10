#!/usr/bin/env bash

cd "$(dirname "$0")"

# turn on verbose debugging output for parabuild logs.
exec 4>&1; export BASH_XTRACEFD=4; set -x

# make errors fatal
set -e

# complain about unreferenced environment variables
set -u

if [ -z "$AUTOBUILD" ] ; then
    exit 1
fi

if [[ "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" ]] ; then
    autobuild="$(cygpath -u $AUTOBUILD)"
else
    autobuild="$AUTOBUILD"
fi

top="$(pwd)"
stage="$top/stage"

# load autobuild provided shell functions and variables
source_environment_tempfile="$stage/source_environment.sh"
"$autobuild" source_environment > "$source_environment_tempfile"
. "$source_environment_tempfile"

# apply_patch
# source "$(dirname "$AUTOBUILD_VARIABLES_FILE")/functions"

# load autobuild provided shell functions and variables
SSE2NEON_SOURCE_DIR="sse2neon"

mkdir -p "$stage/include/sse2neon"
cp -a $SSE2NEON_SOURCE_DIR/*.h "$stage/include/sse2neon"
mkdir -p "$stage/LICENSES"
cp -a "$SSE2NEON_SOURCE_DIR/LICENSE" "$stage/LICENSES/sse2neon.txt"

