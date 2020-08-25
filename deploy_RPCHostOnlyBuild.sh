#!/bin/bash

function usage()
{
    # echo -e "Usage: `basename $1` [-i input url to download dmg file] [-d deploy code]..."
    echo "Usage: curl [URL to download script file] | bash -s -i [URL to download dmg file] -d [deploy code]"
    echo "Example: curl -s https://raw.githubusercontent.com/praja4267/DownloadScriptFile/master/deploy_RPCHostOnlyBuild.sh | bash -s - -i https://static.remotepc.com/downloads/rpc/md/RemotePCHost.dmg -d oWvhyxTRbmcdH9L"
}

CHECK_NEED_DMG_IN="0"
CHECK_NEED_DEPLOY_CODE="0"


#check options
OPTIND=1 # Reset is necessary if getopts was used previously in the script.  It is a good idea to make this local in a function.
while getopts i:d:b: o
do	case "$o" in
	i)
        DMG_IN="$OPTARG"
        CHECK_NEED_DMG_IN="1"
		;;

    d)
        DEPLOY_CODE="$OPTARG"
        CHECK_NEED_DEPLOY_CODE="1"
        ;;
    b)
        DEFAULT_CLIENT_NAME="$OPTARG"
         ;;
	[?])
		echo "invalid option: $1" 1>&2;
		usage "$0"
		exit 1;;
	esac
done

shift $((OPTIND-1)) # Shift off the options and optional --.

if [ "$CHECK_NEED_DMG_IN" == "0" ] ; then
echo "Please input url to download RemotePCHost dmg file!"
usage "$0"
exit 1
fi
echo " url passed = $DMG_IN , deploycode = $DEPLOY_CODE "
curl Ll $DMG_IN > /tmp/RemotePCHost.dmg
if [ ! -d "/Users/Shared/RPCHostOnly" ] ; then mkdir /Users/Shared/RPCHostOnly ; fi
#write .PreInstallData.txt
PRE_INSTALL="/Users/Shared/RPCHostOnly/.PreInstallData.txt"
rm -rf $PRE_INSTALL 
touch "$PRE_INSTALL" 
echo $DEPLOY_CODE  >> "$PRE_INSTALL"
echo "mounting the remotePCHost"
hdiutil attach -nobrowse -noverify /tmp/RemotePCHost.dmg
cp -R /Volumes/RemotePCHost /tmp
hdiutil detach /Volumes/RemotePCHost
echo "started installer at `date` located in `ls /tmp/RemotePCHost/`"
echo "test" | sudo -S installer -target / -pkg /tmp/RemotePCHost/RemotePCHost.pkg
echo "Installation completed at `date`"
rm -rf /tmp/RemotePCHost
rm /tmp/RemotePCHost.dmg
echo "Done!"
open /Applications/RemotePCHost.app
echo "open Command called for host open"
exit 0
