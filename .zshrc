export LANG=en_US.UTF-8

if [[ ! $TERM =~ screen ]]; then
    exec tmux
fi

ZSH_THEME="agnoster"
DEFAULT_USER="ludovic-gonthier"

export ZSH=${HOME}/.oh-my-zsh
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

plugins=(git)

source $ZSH/oh-my-zsh.sh
source ~/.docker.aliases
