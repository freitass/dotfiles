export FZF_DEFAULT_OPTS="--extended --cycle"
export FZF_DEFAULT_COMMAND='(git ls-tree -r --name-only HEAD ||
  find * -name ".*" -prune -o -type f -print -o -type l -print) 2> /dev/null'
