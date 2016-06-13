export LANG=en_US.UTF-8

export GITHUB_TOKEN="ff2cbe398d4dfb439fbddeab5273ec3d93fd01b9"

alias php-command_5.6='docker run \
    -it \
    --rm \
    --dns=172.21.10.41 \
    --add-host=www.lemonde.local:172.30.2.63 \
    --add-host=s1.lemonde.local:172.30.2.63 \
    --add-host=dev.soclesoa.arvato.fr:192.168.31.119 \
    -v /home/lgonthier/workstation/cgi-bin/:/usr/src/cgi-bin/ \
    -v /home/lgonthier/workstation/php-command/:/usr/src/php-command/ \
    -v /var/log/projects/:/var/log/projects/ \
    -v /var/tmp/arvatoExport/:/var/tmp/arvatoExport/ \
    --env GITHUB_TOKEN="ff2cbe398d4dfb439fbddeab5273ec3d93fd01b9" \
    --env PERL5LIB=/usr/src/cgi-bin/lmfr/COMMUNS \
    php-command:5.6'

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

export ZSH=${HOME}/.oh-my-zsh
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
export PATH="$PATH:$HOME/bin"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

plugins=(git)

source $ZSH/oh-my-zsh.sh
source ~/.docker.aliases
PATH="/home/lgonthier/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/lgonthier/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/lgonthier/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/lgonthier/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/lgonthier/perl5"; export PERL_MM_OPT;


function phpd(){
  if  [[ $1 == /* ]]; then MOUNT=$(dirname "$1"); else MOUNT=$PWD; fi
  docker run \
    -it \
    --rm \
    --dns=172.21.10.41 \
    --name \
    php56-"$USER"-"$(date +%s%N)" \
    -v "$MOUNT":"$MOUNT" \
    -w "$MOUNT" \
    loliee/docker-php:5.6 \
    php \
    "$@"
  unset MOUNT
}

function composerd(){
 local args="$*"
 local name="composer-$args"
 if hash date &>/dev/null; then
   name="$name"-"$(date +%s%N)"
 else
   name="$name"-"$(date +%sN)"
 fi
 # shellcheck disable=SC2001
 name="$(echo "$name" | sed "s/[^a-zA-Z0-9_.-]/_/")"
 if  [[ $1 == /* ]]; then mount=$(dirname "$1"); else mount=$PWD; fi
 docker run \
     -ti \
     --rm \
     --name "$name" \
     --env GITHUB_TOKEN="$GITHUB_TOKEN" \
     -v "$mount":"$mount" \
     -w "$mount" loliee/docker-php:5.6 \
    php -n \
    /usr/local/bin/composer.phar config -g github-oauth.github.com "$GITHUB_TOKEN"

 docker run \
     -ti \
     --rm \
     --name "$name" \
     -v "$mount":"$mount" \
     -w "$mount" loliee/docker-php:5.6 \
    php -n \
    /usr/local/bin/composer.phar config --global github-protocols https

 docker run \
     -ti \
     --rm \
     --name "$name" \
     -v "$mount":"$mount" \
     -w "$mount" loliee/docker-php:5.6 \
     php -n \
        -dtimezone=Europe/Paris \
        -dextension=bz2.so \
        -dextension=ftp.so \
        -dextension=intl.so \
        -dextension=mysql.so \
        -dextension=redis.so \
        -dextension=soap.so \
        -dextension=tidy.so \
        -dextension=bcmath.so \
        -dextension=pcntl.so \
        -dextension=pgsql.so \
        -dextension=xsl.so \
        -dextension=zip.so \
        -dmemory_limit=-1 \
        /usr/local/bin/composer.phar \
        "$@"

 unset mount name
}
