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

function set_win_title(){
    echo -ne "\033]0; YOUR_WINDOW_TITLE_HERE \007"
}



# Customize to your needs...
eval "$(starship init zsh)"

starship_precmd_user_func="set_win_title"



alias pbcopy='xclip -selection clipboard'

export GOPATH=~/.go
export PATH=$GOPATH/bin:$PATH
source /usr/share/nvm/init-nvm.sh

[ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"
source /usr/share/nvm/nvm.sh
source /usr/share/nvm/bash_completion
source /usr/share/nvm/install-nvm-exec


alias fdb='docker start fdb'
alias fredis='docker start fredis'
# alias up='xrandr --output HDMI1 --auto --above eDP1'
alias cat='bat --style=changes,header'

[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)
