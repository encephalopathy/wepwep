#!/bin/user/bash
# Run All Lua TestMore Tests to see if anything crashes

echo "**************STARTED TESTING YOUR CHANGES**************"

echo "Rebuilding Started..."
#Copy all files located in the com and org folder to the AutomatedTests folder.
rm -rf automated_tester/com
rm -rf automated_tester/org

cp -r pewpew_corona_port/com/ automated_tester/com
cp -r pewpew_corona_port/org/ automated_tester/org

echo "Rebuilding Complete"

#Change permissions so that we developers can read files.
chmod 755 -R automated_tester/com
chmod 755 -R automated_tester/org

echo "Launching App"
#This will need to be changed for a mac computer
if [ $OSTYPE -eq "cygwin" ]; then
	C:/Program\ Files\ \(x86\)/Corona\ Labs/Corona\ SDK/Corona\ Simulator.exe ./automated_tester/main.lua
else
	/Applications/CoronaSDK/Corona\ Simulator.app/Contents/MacOS/Corona\ Simulator ./automated_tester/main.lua
fi


#simulator /AutomtatedTester/main.lua

#Something fancy