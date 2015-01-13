# hook to load files separated by contexts
run_scripts()
{
  for script in $1/*; do
    #skip non-executable snippets
    [ -x "$script"  ] || continue

    # execute $script in the context of the current shell
    . $script
  done
}

run_scripts ~/.bash_aliases.d
