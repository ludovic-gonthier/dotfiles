# Vagrant PART
# export WORKSPACE="${HOME}/vagrant_root"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

if [[ ! $TERM =~ screen ]]; then
    exec `tmux attach -t base || tmux new -s base`
fi

export PATH="$HOME/bin:$PATH"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
export PATH="./node_modules/.bin:$PATH"

plugins=(git)

source $ZSH/oh-my-zsh.sh
if [ -f "$HOME/.zshrc.local" ] ; then
	source "$HOME/.zshrc.local"
fi

source ~/.aliases
