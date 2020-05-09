#!/usr/bin/env python
# -*- coding: utf-8 -*-


### ------------------
### Imports and pipes
### ------------------

import os
import sys
reload(sys)
sys.setdefaultencoding('utf-8')
import subprocess
import shutil


def run(params):
    p = subprocess.Popen(params, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    for line in p.stdout.readlines():
        print(line)
    return p.wait()
    

### ------------------
### Parameter checking
### ------------------

blankModuleName = 'Blank'

if len(sys.argv) != 2:
    sys.exit('Usage: %s %s' % (sys.argv[0], 'NewModuleName'))    

newModuleName = sys.argv[1]

### ------------------
### Folder check
### ------------------

blankModulePath = './' + blankModuleName
blankModulePathExists = os.path.exists(blankModulePath)

if not blankModulePathExists:
	sys.exit('Template module %s does not exist in the current directory' % blankModuleName)


newModulePath = './' + newModuleName
newModulePathExists = os.path.exists(newModulePath )
if newModulePathExists:
	sys.exit('Found already existing module %s' % newModuleName)

### ------------------
### Create Module
### ------------------

# Copy files
shutil.copytree(blankModulePath, newModulePath)
# os.system('rsync -aI %s %s' % (blankModulePath, newModulePath))

# Rename files

for path, dirs, files in os.walk(newModulePath):
	for directory in dirs:
		if directory.startswith("Blank"):
			newDirName = directory.replace("Blank", newModuleName)
			os.rename(os.path.join(path, directory), os.path.join(path, newDirName))

	for filename in files:
		newFilename = filename.replace("Blank", newModuleName)

		if filename.startswith("Blank"):
			os.rename(os.path.join(path, filename), os.path.join(path, newFilename))

		# Rename content
		fileToRenameContentPath = os.path.join(path, newFilename)
		f = open(fileToRenameContentPath,'r')
		filedata = f.read()
		f.close()

		newdata = filedata.replace("BlankView", newModuleName + "View")
		newdata = filedata.replace("Blank", newModuleName)

		f = open(fileToRenameContentPath,'w')
		f.write(newdata)
		f.close()
            	

