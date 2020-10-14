# exa
alias ls='exa -abghHliS'
alias lst='exa -lT'

# procs
alias ps='procs --sortd cpu'
alias pst='procs --tree'

# cd ls
function cd
  builtin cd $argv
    lst
end
