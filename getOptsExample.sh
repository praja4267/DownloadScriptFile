#!/bin/zsh

function usage()
{
    echo -e "Usage: `basename $1` [-i input streamer dmg file] [-d deploy code]..."
    echo "Example: curl https://raw.githubusercontent.com/praja4267/DownloadScriptFile/master/deploy_RPCHostOnlyBuild.sh | bash -s -a apple -b banana -c cherry -d dfruit -e eggplant -f fig
}

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

# call this script from terminal as shown below
# ./getOptsExample.sh -a apple -b banana -c cherry -d dfruit -e eggplant -f fig

# The usage function is defined to show the user how pass params to this script. paste the below line in terminal
# ./getOptsExample.sh -d apple -b banana -c cherry -d dfruit -e eggplant -f fig

### Example 2:
# while getopts ":a:b:c:d:e:f:" o
# do
#     case $o in
#         a ) APPLE="$OPTARG";;
#         b ) BANANA="$OPTARG";;
#         c ) CHERRY="$OPTARG";;
#         d ) DFRUIT="$OPTARG";;
#         e ) EGGPLANT="$OPTARG";;
#         f ) FIG="$OPTARG";;
#         \?) echo "Invalid option: -"$OPTARG"" >&2
#             exit 1;;
#         : ) echo "Option -"$OPTARG" requires an argument." >&2
#             exit 1;;
#     esac
    
# done
# echo "Apple is "$APPLE""
# echo "Banana is "$BANANA""
# echo "Cherry is "$CHERRY""
# echo "Dfruit is "$DFRUIT""
# echo "Eggplant is "$EGGPLANT""
# echo "Fig is "$FIG""

# call this script from terminal as shown below
# ./getOptsExample.sh -a apple -b banana -c cherry -d dfruit -e eggplant -f fig