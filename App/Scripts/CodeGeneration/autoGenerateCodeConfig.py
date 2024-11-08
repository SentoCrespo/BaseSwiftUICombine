#!/usr/bin/env python3
# -*- coding: utf-8 -*-

### ------------------
### Imports
### ------------------

import os
import sys
import subprocess
import argparse
import time
# Make sure to execute in a terminal if needed
# export PYTHONIOENCODING=UTF-8

def myPrint(string):
    print(string.encode("ascii", "ignore").decode("ascii"))

### ------------------
### Method Definition
### ------------------
def run(params):
    p = subprocess.Popen(params, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    return p.wait()

### ------------------
### Main entry point
### ------------------
startTime = time.time()

pwd = os.getcwd()
myPrint('Current directory: ' + pwd)

# Configuration/Default variables
defaultProjectPath = pwd
defaultSourceryPath = pwd + '/../Pods/Sourcery'
defaultSourceryBin = defaultSourceryPath + '/bin/sourcery'
defaultConfigurationPath = pwd + '/Autogeneration.config'

parser = argparse.ArgumentParser(description = 'Auto Generate code with sourcery')

parser.add_argument('--sourceryBin',
                    action = 'store',
                    dest = 'sourceryBin',
                    default = defaultSourceryBin,
                    help = 'Sourcery Binary filepath')
                    
parser.add_argument('--config',
                    action = 'store',
                    dest = 'config',
                    default = defaultConfigurationPath,
                    help = 'Configuration file path')

args = parser.parse_args()

# Execute sourcery
sourcery = args.sourceryBin

myPrint('Generating code')
command1 = args.sourceryBin + ' --config ' + args.config
myPrint('Trying: \n' + command1)
os.system(command1)

endTime = time.time()

runTime = endTime - startTime

myPrint("")
myPrint("Code autogeneration done in %0.1f seconds" % runTime)
myPrint("")

# Build phase example
#"${SRCROOT}"/Autogenerated/autoGenerateCodeConfig.py \
#    --sourceryBin './Pods/Sourcery/bin/sourcery' \
#    --config './Autogenerated/Autogeneration.config'
