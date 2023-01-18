# git branch delete
function git_branch_delete() {
  prefix=($1);

  if (( $#prefix == 0 )); then
    echo "Usage: git_branch_delete <prefix>";
    return -1;
  fi

  current=(`git branch --show-current`);

  foreach b (`git branch`)
    if [[ $b =~ "^$prefix" && $b != $current ]]; then
      git branch -D $b;
    fi
  end
}

# zle
zle -N git_branch_delete