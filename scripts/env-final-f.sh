#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/env-f.sh"
export JAVA_HOME="$DIVEFUZZ_ROOT/.local/jdk17"
export PATH="$JAVA_HOME/bin:$DIVEFUZZ_ROOT/.local/bin:$PATH"
export JAVA_TOOL_OPTIONS="-Duser.home=$DIVEFUZZ_ROOT/.local/java-home -Djava.io.tmpdir=$TMPDIR -Xmx4g"
export COURSIER_CACHE="$XDG_CACHE_HOME/coursier"
export COURSIER_REPOSITORIES='https://repo.maven.apache.org/maven2'
export MILL_DOWNLOAD_PATH="$XDG_CACHE_HOME/mill"
export MILL_WORKSPACE_ROOT="$DIVEFUZZ_ROOT/dut/NutShell"
export IVY_HOME="$XDG_CACHE_HOME/ivy"
export CCACHE_DIR="$XDG_CACHE_HOME/ccache"
export NOOP_HOME="$DIVEFUZZ_ROOT/dut/NutShell"
mkdir -p "$DIVEFUZZ_ROOT/.local/bin" "$DIVEFUZZ_ROOT/.local/java-home" "$COURSIER_CACHE"
