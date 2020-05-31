#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

function set_win_title(){
	echo -ne "\033]0;  $(basename "`pwd`")  \007"
}

precmd_functions+=(set_win_title)



alias pbcopy='xclip -selection clipboard'

export GOPATH=~/.go
export PATH=$GOPATH/bin:$PATH
export KUBE_EDITOR='vim'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion



alias fdb='docker start fdb'
alias fredis='docker start fredis'
# alias up='xrandr --output HDMI1 --auto --above eDP1'
alias cat='bat --style=changes,header'
alias fenv='source /home/sumit/.go/src/bitbucket.org/logiqcloud/redash-fork/venv/bin/activate'
alias kx='kubectx|fzf'
source <(minikube completion zsh)
[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)


source ~/.myStuff
eval "$(starship init zsh)"

