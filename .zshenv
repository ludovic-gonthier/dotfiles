# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprofile"
fi

export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export NVM_DIR="$HOME/.nvm"

export PATH="/usr/local/sbin"
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/usr/sbin"
export PATH="$PATH:/usr/bin"
export PATH="$PATH:/sbin"
export PATH="$PATH:/bin"
export PATH="$PATH:/usr/games"
export PATH="$PATH:/usr/local/games"
export PATH="$PATH:./node_modules/.bin"

export ZSH=${HOME}/.oh-my-zsh
export ZSH_THEME="agnoster"
export DEFAULT_USER=${USERNAME}

if [ -f "$HOME/.zshenv.local" ] ; then
    source "$HOME/.zshenv.local"
fi

if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
