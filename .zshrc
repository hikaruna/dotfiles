bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^l' forward-word
bindkey '^h' backward-word
bindkey "^r" history-substring-search-up
zmodload zsh/terminfo
bindkey "$terminfo[cuu1]" history-substring-search-up

eval "$(rbenv init - zsh)"

eval "$(direnv hook zsh)"
