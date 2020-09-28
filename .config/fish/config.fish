# WLSでWindowsのエクスプローラーで開く
alias open='explorer.exe'
alias e='explorer.exe .'

alias home='cd $HOME'
alias whome='cd /mnt/c/Users/rind0'

# exa
alias ls='exa -abghHliS'
alias lst='exa -lT'

# procs
alias ps='procs --sortd cpu'
alias pst='procs --tree'

# powerline-rs
function fish_prompt
  powerline-rs --shell bare $status
end

# cd ls
function cd
  builtin cd $argv
    lst
end
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH
