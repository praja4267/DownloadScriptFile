#!/bin/zsh

function usage()
{
    echo -e "Usage: `basename $1` [-i input streamer dmg file] [-d deploy code]..."
    echo -e "Example: curl https://raw.githubusercontent.com/praja4267/DownloadScriptFile/master/getOptsExample.sh | bash -s -a apple -b banana -c cherry"
}

echo "Params passed in are $@ "
while getopts a:b:c: o
do
    case $o in
        a) VAR_A="$OPTARG";;
        b) VAR_B="$OPTARG";;
        c) VAR_C="$OPTARG";;
        *) echo "invalid option: $1" 1>&2;
		usage "$0"
		exit 1;;
    esac
done

echo "a = $VAR_A"
echo "b = $VAR_B"
echo "c = $VAR_C"