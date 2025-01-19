# ghq + fzf

# for Standard
function ghq_fzf_repo() {
  local repo=$(ghq list | fzf --preview "ghq list --full-path --exact {} | xargs eza -h --long --icons --classify --git --no-permissions --no-user --no-filesize --git-ignore --sort modified --reverse --tree --level 2")
  if [ -n "$repo" ]; then
    repo=$(ghq list --full-path --exact $repo)
    BUFFER="cd ${repo}"
    zle accept-line
  fi
  zle clear-screen
}

# zle
zle -N ghq_fzf_repo

# key bindings
bindkey '^g' ghq_fzf_repo

# for Warp
function g() {
  local repo=$(ghq list | fzf --preview "ghq list --full-path --exact {} | xargs eza -h --long --icons --classify --git --no-permissions --no-user --no-filesize --git-ignore --sort modified --reverse --tree --level 2")
  if [ -n "$repo" ]; then
    cd $(ghq root)/$repo
  fi
}
