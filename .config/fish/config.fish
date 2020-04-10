# WLSでWindowsのエクスプローラーで開く
alias open='explorer.exe'
alias e='explorer.exe .'

alias home='cd $HOME'
alias whome='cd /mnt/c/Users/rind0'

# cd ls
function cd
  builtin cd $argv
    ls -a
end
