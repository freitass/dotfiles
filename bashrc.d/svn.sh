function svngrep() {

if [ "$#" -ne 2 ]; then
  cat << EOF
usage: $FUNCNAME <filename> <pattern>

Original solution http://stackoverflow.com/a/2742851/89112
EOF
  return 1
fi

file="$1"
pattern="$2"

REVISIONS=`svn log $file -q --stop-on-copy |grep "^r" | cut -d"r" -f2 | cut -d" " -f1`

for rev in $REVISIONS; do
  prevRev=$(($rev-1))
  difftext=`svn diff --old=$file@$prevRev --new=$file@$rev | tr -s " " | grep -v " -\ \- " | grep -e "$pattern"`
  if [ -n "$difftext" ]; then
    echo "$rev: $difftext"
  fi
done
}
