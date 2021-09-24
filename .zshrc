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
	echo -ne "\033]0;    $(basename "`pwd`")  \007"
}

precmd_functions+=(set_win_title)



alias pbcopy='xclip -selection clipboard'

export GOPATH=~/.go
export PATH=$GOPATH/bin:$PATH
export KUBE_EDITOR='vim'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion



alias fdb='docker start cpostgres'
alias fredis='docker start credis'
alias fminio='docker start cminio'
# alias up='xrandr --output HDMI1 --auto --above eDP1'
alias cat='batcat --style=changes,header'
alias fenv='source /home/sumit/.go/src/bitbucket.org/logiqcloud/redash-fork/venv/bin/activate'
alias kx='kubectl -n logiq'
source <(minikube completion zsh)
[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)


source ~/.myStuff
function logiq(){
	docker rm -f $(docker ps -aq)
	docker create --name fredis -p 6379:6379   redis
	docker create --name fdb -p 5432:5432 -e POSTGRES_PASSWORD=postgres -e POSTGRES_USERNAME=postgres  postgres
	docker create --name fminio \
  -p 9000:9000 \
  -p 9001:9001 \
  -e "MINIO_ROOT_USER=AKIAIOSFODNN7EXAMPLE" \
  -e "MINIO_ROOT_PASSWORD=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY" \
  minio/minio server /data --console-address ":9001"
	docker start fredis
docker start fdb
docker start fminio
}

function ff(){
	docker start fredis
docker start fdb
docker start fminio
}

export QUERY_REPORTING_HOST="localhost"
eval "$(starship init zsh)"

