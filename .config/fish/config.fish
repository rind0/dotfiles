export PATH="$HOME/.cargo/bin:$PATH"

# exa
alias ls='exa -abghHliS'
alias lst='exa -lTL=4'

# procs
alias ps='procs --sortd cpu'
alias pst='procs --tree'

# cd ls
function cd
  builtin cd $argv
    ls
end
