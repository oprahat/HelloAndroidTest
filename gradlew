#!/usr/bin/env sh

#
# Copyright 2015 the original author or authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Add default JVM options here. You can also use JAVA_OPTS and GRADLE_OPTS to pass JVM options to this script.
DEFAULT_JVM_OPTS=""

APP_NAME="Gradle"
APP_BASE_NAME=`basename "$0"`

# Use the maximum available, or set MAX_FD != -1 to use that value.
MAX_FD="maximum"

warn () {
    echo "$*"
}

die () {
    echo
    echo "ERROR: $*"
    echo
    exit 1
}

# OS specific support (must be 'true' or 'false').
cygwin=false
msys=false
darwin=false
nonstop=false
case "`uname`" in
  CYGWIN* )
    cygwin=true
    ;;
  Darwin* )
    darwin=true
    ;;
  MSYS* | MINGW* )
    msys=true
    ;;
  NONSTOP* )
    nonstop=true
    ;;
esac

# Attempt to retrieve JAVA_HOME from locating java
if [ -z "$JAVA_HOME" ] ; then
    java_exe_path=$(which java 2>/dev/null)
    if [ "x$java_exe_path" != "x" ] ; then
        java_exe_path=$(readlink -f "$java_exe_path")
        JAVA_HOME=$(dirname "$(dirname "$java_exe_path")")
    fi
fi

if [ -z "$JAVA_HOME" ] ; then
    die "ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH."
fi

# Determine the Java command to use to start the JVM.
if [ -n "$JAVA_HOME" ] ; then
    if [ -x "$JAVA_HOME/jre/sh/java" ] ; then
        # IBM's JDK on AIX uses strange locations for the executables
        JAVACMD="$JAVA_HOME/jre/sh/java"
    else
        JAVACMD="$JAVA_HOME/bin/java"
    fi
    if [ ! -x "$JAVACMD" ] ; then
        die "ERROR: JAVA_HOME is set to an invalid directory: $JAVA_HOME

Please set the JAVA_HOME variable in your environment to match the
location of your Java installation."
    fi
else
    JAVACMD="java"
    which java >/dev/null 2>&1 || die "ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH."
fi

# Increase the maximum number of open file descriptors on OS X.
if $darwin; then
    if [ "$MAX_FD" = "maximum" -o "$MAX_FD" = "max" ]; then
        # Use the maximum available.
        MAX_FD=`ulimit -H -n`
    fi
    ulimit -n $MAX_FD
fi

# For Cygwin, ensure paths are in UNIX format before passing them to Java
if $cygwin ; then
    [ -n "$GRADLE_HOME" ] && GRADLE_HOME=`cygpath --unix "$GRADLE_HOME"`
    [ -n "$JAVA_HOME" ] && JAVA_HOME=`cygpath --unix "$JAVA_HOME"`
    [ -n "$CLASSPATH" ] && CLASSPATH=`cygpath --path --unix "$CLASSPATH"`
fi

# For MSYS, ensure paths are in UNIX format before passing them to Java
if $msys ; then
    [ -n "$GRADLE_HOME" ] && GRADLE_HOME=`(cd "$GRADLE_HOME"; pwd)`
    [ -n "$JAVA_HOME" ] && JAVA_HOME=`(cd "$JAVA_HOME"; pwd)`
    # TODO classpath?
fi

# Setup the command line arguments.
# Add the command-line arguments to GRADLE_OPTS. As the shell script is called by gradlew, the first
# three arguments are gradlew, --no-search-upwards and the original command. These are removed here.
#
# A BUG exists in removed in bash version 4.3 under Darwin on Yosemite which mis-handles manipulating arrays
# defined in a sub-shell. It has been fixed in 4.3.30. This is why the following is not:
#
# if $darwin && [ "${BASH_VERSINFO[0]}" -le 4 ] && [ "${BASH_VERSINFO[1]}" -lt 3 ] ; then
#     GRADLE_OPTS=("$@")
# else
#     GRADLE_OPTS=( "${@:4}" )
# fi
#
# For the moment, this is not a significant enough issue to worry about. The original command is available via
# the process listing.
#
GRADLE_OPTS=("$@")

# Find the project root, which is the location of this script.
# A simple 'dirname $0' will not work as it is not safe for cases where gradlew is a symlink
# and we want the path to the symlink, not the real file.
if [ -n "$BASH_SOURCE" ] ; then
  # We are in bash.
  if [ -L "$BASH_SOURCE" ] ; then
    # This script is a symlink.
    APP_HOME=$(cd `dirname \`readlink "$BASH_SOURCE"\``; pwd)
  else
    # This script is not a symlink.
    APP_HOME=$(cd `dirname "$BASH_SOURCE"`; pwd)
  fi
else
  # We are not in bash.
  APP_HOME=$(cd `dirname "$0"`; pwd)
fi

# Add the gradle-wrapper.jar to the classpath.
# The jar must be located in the gradle directory under the project root.
# A simple 'cd ..' will not work as it is not safe for cases where gradlew is a symlink
# and we want the path relative to the symlink, not the real file.
WRAPPER_JAR="$APP_HOME/gradle/wrapper/gradle-wrapper.jar"
WRAPPER_PROPERTIES="$APP_HOME/gradle/wrapper/gradle-wrapper.properties"

# Split up the JVM options string into an array, following the shell quoting and substitution rules.
function splitJvmOpts() {
    JVM_OPTS=("$@")
}
eval splitJvmOpts $DEFAULT_JVM_OPTS $JAVA_OPTS $GRADLE_OPTS
JVM_OPTS[${#JVM_OPTS[*]}]="-Dorg.gradle.appname=$APP_BASE_NAME"

# Escape the classpath for the determined shell.
if $cygwin; then
  case "$OSTYPE" in
    cygwin*)
      # Cygwin under Windows.
      if [ -n "$CLASSPATH" ] ; then
        CLASSPATH="$WRAPPER_JAR":"$CLASSPATH"
      else
        CLASSPATH="$WRAPPER_JAR"
      fi
      CLASSPATH=`cygpath --path --windows "$CLASSPATH"`
      ;;
    *)
      # MSYS under Windows.
      if [ -n "$CLASSPATH" ] ; then
        CLASSPATH="$WRAPPER_JAR";"$CLASSPATH"
      else
        CLASSPATH="$WRAPPER_JAR"
      fi
      ;;
  esac
else
  if [ -n "$CLASSPATH" ] ; then
    CLASSPATH="$WRAPPER_JAR":"$CLASSPATH"
  else
    CLASSPATH="$WRAPPER_JAR"
  fi
fi

exec "$JAVACMD" "${JVM_OPTS[@]}" -classpath "$CLASSPATH" org.gradle.wrapper.GradleWrapperMain "$@"
