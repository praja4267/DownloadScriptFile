#!/bin/sh



#### For RPCHostOnly
##https://github.com/praja4267/DownloadScriptFile/archive/master.zip
##
##https://static.remotepc.com/downloads/rpc/md/RemotePCHost.dmg
##https://static.remotepc.com/downloads/rpc/140820/RemotePCHost.dmg

### script starting point

#curl Ll https://static.remotepc.com/downloads/rpc/md/RemotePCHost.dmg > /tmp/RemotePCHost.dmg && \
#if [ ! -d "/Users/Shared/RPCHostOnly" ] ; then mkdir /Users/Shared/RPCHostOnly ; fi && \
#PRE_INSTALL="/Users/Shared/RPCHostOnly/.PreInstallData.txt" && \
#rm -rf $PRE_INSTALL && \
#touch "$PRE_INSTALL" && \
#DEPLOY_CODE="oWvhyxTRbmcdH9L" && \
#echo $DEPLOY_CODE  >> "$PRE_INSTALL" && \
#echo "mounting the remotePCHost" && \
#hdiutil attach -nobrowse -noverify /tmp/RemotePCHost.dmg && \
#cp -R /Volumes/RemotePCHost /tmp && \
#hdiutil detach /Volumes/RemotePCHost && \
#echo "Date defore = `date`" && \
#echo "Un mounted the remotePCHost and started installing RemotePCHost.pkg from temp" && \
#echo "test" | sudo -S installer -target / -pkg /tmp/RemotePCHost/RemotePCHost.pkg && \
#echo "Date defore = `date`" && \
#echo "installing RemotePCHost.pkg completed so removing temp folder and dmg file" && \
#rm -rf /tmp/RemotePCHost && \
#rm /tmp/RemotePCHost.dmg && \
#echo "removed the temp files and exiting terminal"

### Script ending point

##usage starting:

## curl https://raw.githubusercontent.com/praja4267/DownloadScriptFile/master/DownloadScriptFile.sh | bash -s arg1 arg2
## curl -s https://raw.githubusercontent.com/praja4267/DownloadScriptFile/master/DownloadScriptFile.sh | bash -s arg1 arg2
## curl -s -L https://raw.githubusercontent.com/praja4267/DownloadScriptFile/master/DownloadScriptFile.sh | bash


if [ $# ne "1" ] 
then 
    echo "Number of params passed = $# "
else 
    echo "Wrong number of params"
fi

echo "Supplied params are = $@"

