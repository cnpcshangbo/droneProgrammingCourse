#BASEDIR=$(dirname $0)
BASEDIR="$( cd "$( dirname "$0" )" && pwd )"
echo script location ${BASEDIR}
echo "alias scd='cd ${BASEDIR}'" >> ~/.zshrc
echo Open a new terminal and use 'scd' to change to this script folder.
