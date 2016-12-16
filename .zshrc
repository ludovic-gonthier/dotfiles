

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

if [[ ! $TERM =~ screen ]]; then
    exec tmux
fi

ZSH_THEME="agnoster"
DEFAULT_USER="ludovic-gonthier"

[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

plugins=(git)

source $ZSH/oh-my-zsh.sh
source ~/.aliases

if [ -d "$HOME/.zshrc.local" ] ; then
	source "$HOME/.zshrc.local"
fi
if [ -d "$HOME/.aliases.local" ] ; then
	source "$HOME/.zshrc.local"
fi
