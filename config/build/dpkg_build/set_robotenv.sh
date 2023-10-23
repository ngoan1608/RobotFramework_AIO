#!/bin/bash

#create environment variables
export RobotPythonPath=/opt/rfwaio/python39/install/bin
export RobotScriptPath=/opt/rfwaio/python39/install/bin
export RobotVsCode=/opt/rfwaio/robotvscode
export RobotToolsPath=/opt/rfwaio/tools
export RobotTestPath=~/RobotTest/testcases
export RobotLogPath=~/RobotTest/logfiles
export RobotTutorialPath=~/RobotTest/tutorial
export GENDOC_PLANTUML_PATH=$RobotVsCode/data/extensions/jebbs.plantuml-2.17.5


# Check if JAVA_HOME is already set
if [ -z "$JAVA_HOME" ]; then
    JDK_PATH=$(readlink -f $(which java) 2> /dev/null) 2> /dev/null
    if [ -n "$JDK_PATH" ]; then
        export JAVA_HOME=$(dirname $(dirname $JDK_PATH)) 2> /dev/null
    fi
fi
