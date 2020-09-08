#!/bin/bash

function usage()
{
    # echo -e "Usage: `basename $1` [-i input url to download dmg file] [-d deploy code]..."
    echo "Usage: sh [path to script file] [deploy code]"
    echo "Example: sh /tmp/RPCHost/deploy_RPCHostOnlyBuild.sh oWvhyxTRbmcdH9L"
}


DMG_DIR="$(dirname $0)"
DMG_IN="$DMG_DIR/RemotePCHost.dmg"

if [ $# -eq "1" ]
then
    DEPLOY_CODE=$1
else
    echo "need to pass 1 argument (i.e. DeployCode), but passed $# arguments"
    usage "$0"
    exit 1
fi

if [ -f "$DMG_IN" ]
then
    echo " dmg path = $DMG_IN , deploycode = $DEPLOY_CODE "
else
    echo "files in current folder are 'ls /tmp/RPCHost'"
    echo "DMG file does not exist"
    usage "$0"
    exit 1
fi

if [ ! -d "/Users/Shared/RPCHostOnly" ] ; then mkdir /Users/Shared/RPCHostOnly ; fi
#write .PreInstallData.txt
PRE_INSTALL="/Users/Shared/RPCHostOnly/.PreInstallData.txt"
rm -rf $PRE_INSTALL
touch "$PRE_INSTALL"
echo $DEPLOY_CODE  >> "$PRE_INSTALL"
chmod -R 777 "/Users/Shared/RPCHostOnly"
echo "mounting the remotePCHost"
hdiutil attach -nobrowse -noverify "$DMG_IN"
cp -R /Volumes/RemotePCHost /tmp/RPCHost
hdiutil detach /Volumes/RemotePCHost
echo "started installer at `date` located in `ls /tmp/RPCHost/`"
installer -target / -pkg "$DMG_DIR/RemotePCHost/RemotePCHost.pkg"
echo "package location = $DMG_DIR/RemotePCHost/RemotePCHost.pkg"
echo "Installation completed at `date`"
#sleep 15  # sleep for 15 seconds
rm -rf $DMG_DIR
echo "Done!"
open /Applications/RemotePCHost.app
echo "open Command called for host open"
exit 0
