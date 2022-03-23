# nvim
alias vi='nvim'

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

alias cls='clear && ls'
alias reflectorjp='sudo reflector --country 'Japan' --age 24 --protocol https --sort rate --save /etc/pacman.d/mirrorlist'
