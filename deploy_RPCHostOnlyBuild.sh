#!/bin/bash

function usage()
{
    # echo -e "Usage: `basename $1` [-i input url to download dmg file] [-d deploy code]..."
    echo "Usage: curl [URL to download script file] | bash -s - [-i URL to download dmg file] [-d deploy code] [-g groupName] [-h hideTray(0 = false , 1 = true)] [-p PersonalKey]"
    echo "Example: curl -s https://raw.githubusercontent.com/praja4267/DownloadScriptFile/master/deploy_RPCHostOnlyBuild.sh | bash -s - -i https://static.remotepc.com/downloads/rpc/md/RemotePCHost.dmg -d oWvhyxTRbmcdH9L -g MyGroup -h 0 -p 1234"
}


CHECK_DMG_IN="0"
CHECK_DEPLOY_CODE="0"
CHECK_GROUP_NAME="0"
CHECK_HIDE_TRAY="0"
CHECK_PERSONAL_KEY="0"

#check options
OPTIND=1 # Reset is necessary if getopts was used previously in the script.  It is a good idea to make this local in a function.
while getopts i:d:g:h:p: o
do    case "$o" in
    i)
        DMG_IN="$OPTARG"
        CHECK_DMG_IN="1"
        ;;

    d)
        DEPLOY_CODE="$OPTARG"
        CHECK_DEPLOY_CODE="1"
        ;;
    g)
        GROUP_NAME="$OPTARG"
        CHECK_GROUP_NAME="1"
        ;;
    h)
        HIDE_TRAY="$OPTARG"
        CHECK_HIDE_TRAY="1"
        ;;
    p)
        PERSONAL_KEY="$OPTARG"
        CHECK_PERSONAL_KEY="1"
        ;;
    [?])
        echo "invalid option: $1" 1>&2;
        usage "$0"
        exit 1;;
    esac
done
shift $((OPTIND-1)) # Shift off the options and optional --.

if [ "$CHECK_DMG_IN" == "0" ] ; then
echo "Please input url to download RemotePCHost dmg file!"
usage "$0"
exit 1
fi

JSONSTRING="{"

if [ "$CHECK_DEPLOY_CODE" == "1" ] ; then JSONSTRING="$JSONSTRING\"deployCode\": \"$DEPLOY_CODE\"" ; fi
if [ "$CHECK_GROUP_NAME" == "1" ] ; then JSONSTRING="$JSONSTRING, \"groupName\": \"$GROUP_NAME\"" ; fi
if [ "$CHECK_HIDE_TRAY" == "1" ] ; then JSONSTRING="$JSONSTRING, \"hideTray\": \"$HIDE_TRAY\"" ; fi
if [ "$CHECK_PERSONAL_KEY" == "1" ] ; then JSONSTRING="$JSONSTRING, \"personalKey\": \"$PERSONAL_KEY\"" ; fi

JSONSTRING="$JSONSTRING}"

echo " url passed = $DMG_IN , deploycode = $DEPLOY_CODE , groupName = $GROUP_NAME, personalKey = $PERSONAL_KEY"
curl Ll $DMG_IN > /tmp/RemotePCHost.dmg
if [ ! -d "/Users/Shared/RPCHostOnly" ] ; then mkdir /Users/Shared/RPCHostOnly ; fi
#write .PreInstallData.txt
PRE_INSTALL="/Users/Shared/RPCHostOnly/.PreInstallData.txt"
rm -rf $PRE_INSTALL 
touch "$PRE_INSTALL"
if [ ! "$DEPLOY_CODE" == "" ]; then
echo $JSONSTRING  >> "$PRE_INSTALL"
fi
chmod -R 777 "/Users/Shared/RPCHostOnly"
if [ "$CHECK_DMG_IN" == "1" ]; then

echo "mounting the remotePCHost"
hdiutil attach -nobrowse -noverify /tmp/RemotePCHost.dmg
cp -R /Volumes/RemotePCHost /tmp
echo "Unmount dmg"
hdiutil detach /Volumes/RemotePCHost

NORMAL_INSTALLER="/tmp/RemotePCHost/RemotePCHost.pkg"
if [ -f "$NORMAL_INSTALLER" ]; then
echo "started  silent installation at `date` located in `ls /tmp/RemotePCHost/`"
sudo installer -pkg "$NORMAL_INSTALLER" -target /
echo "Installation completed at `date`"
fi

echo "Done!"
open /Applications/RemotePCHost.app
echo "open Command called for host open"

if [ -d "/tmp/RPCHost" ] ; then
rm -rf "/tmp/RPCHost"
echo "deleted RPCHost from tmp folder"
fi

exit 0
