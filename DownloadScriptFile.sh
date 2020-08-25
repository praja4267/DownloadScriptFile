#!/bin/sh

#### For RPCHostOnly

//https://static.remotepc.com/downloads/rpc/md/RemotePCHost.dmg
//https://static.remotepc.com/downloads/rpc/140820/RemotePCHost.dmg

curl Ll https://static.remotepc.com/downloads/rpc/md/RemotePCHost.dmg > /tmp/RemotePCHost.dmg && \
if [ ! -d "/Users/Shared/RPCHostOnly" ] ; then mkdir /Users/Shared/RPCHostOnly ; fi && \
PRE_INSTALL="/Users/Shared/RPCHostOnly/.PreInstallData.txt" && \
rm -rf $PRE_INSTALL && \
touch "$PRE_INSTALL" && \
DEPLOY_CODE="oWvhyxTRbmcdH9L" && \
echo $DEPLOY_CODE  >> "$PRE_INSTALL" && \
echo "mounting the remotePCHost" && \
hdiutil attach -nobrowse -noverify /tmp/RemotePCHost.dmg && \
cp -R /Volumes/RemotePCHost /tmp && \
hdiutil detach /Volumes/RemotePCHost && \
echo "Date defore = `date`" && \
echo "Un mounted the remotePCHost and started installing RemotePCHost.pkg from temp" && \
echo "test" | sudo -S installer -target / -pkg /tmp/RemotePCHost/RemotePCHost.pkg && \
echo "Date defore = `date`" && \
echo "installing RemotePCHost.pkg completed so removing temp folder and dmg file" && \
rm -rf /tmp/RemotePCHost && \
rm /tmp/RemotePCHost.dmg && \
echo "removed the temp files and exiting terminal"
