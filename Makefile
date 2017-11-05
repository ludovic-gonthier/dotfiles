PACKAGES := git pip zsh ctags
SHELL := /bin/bash

.PHONY: install 
install: requirements \
	install-prerequisites \
	install-vim \
	install-tmux \
	install-powerline \
	install-oh-my-zsh
	@stow -S -R . -t "${HOME}" -v
	# Update fonts cache
	@sudo fc-cache -vf

.PHONY: install-prerequisites 
install-prerequisites:
	$(info --> Prerequisites for DOTFiles)
	@yes | sudo apt-get install stow git zsh
	$(info --> Prerequisites for TMUX)
	@yes | sudo apt-get install libevent-dev libncurses-dev pkg-config autoconf
	$(info --> Prerequisites for VIM)
	@yes | sudo apt-get install exuberant-ctags 

.PHONY: install-tmux 
install-tmux:
	$(info --> Install TMUX)
	[[ -d ${HOME}/src/tmux ]] || git clone git@github.com:tmux/tmux.git ${HOME}/src/tmux/
	@mkdir -p ${HOME}/share/man/man1
	@cd ${HOME}/src/tmux/ && sh autogen.sh && ./configure --prefix=${HOME} && make && make install
	$(info   --> Install Tmux-tpm)
	@mkdir -p ${HOME}/.tmux/plugins
	@[[ -d ${HOME}/.tmux/plugins/tpm ]] || git clone https://github.com/tmux-plugins/tpm ${HOME}/.tmux/plugins/tpm

.PHONY: install-vim
install-vim:
	$(info --> Installing VIM)
	[[ -d ${HOME}/src/vim ]] || git clone git@github.com:vim/vim.git ${HOME}/src/vim/
	$(info   --> Configuring Vim sources)
	cd ${HOME}/src/vim  && \
	./configure --prefix=${HOME}\
		--enable-pythoninterp=yes \
		--with-python-config-dir=/usr/lib/python2.7/config-$(uname -m)-linux-gnu \
		--with-features=huge \
		--enable-rubyinterp=dynamic \
		--enable-perlinterp=dynamic \
	   	--enable-cscope
	$(info   --> Compilling VIM)
	cd ${HOME}/src/vim && make && sudo make install

	$(info --> Configuring Vim bundles)
	$(info   --> Installing Vim-Vundle)
	@mkdir -p ${HOME}/.vim/bundle
	@mkdir -p ${HOME}/.vim/undofiles
	@[[ -d ${HOME}/.vim/bundle/Vundle.vim ]] || git clone https://github.com/gmarik/Vundle.vim.git ${HOME}/.vim/bundle/Vundle.vim
	$(info --> Installing Vim Plugins)
	@vim +PluginInstall +qall &>/dev/null 

.PHONY: install-powerline
install-powerline:
	$(info   --> Installing Powerline)
	@pip install --user git+git://github.com/Lokaltog/powerline
	$(info   --> Installing Powerline fonts)
	@wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
	@sudo mv PowerlineSymbols.otf /usr/share/fonts/
	@sudo fc-cache -vf
	@sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/

.PHONY: install-oh-my-zsh
install-oh-my-zsh:
	$(info   --> Installing Oh My Zsh)
	wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sudo sh	
	if [ ! -e ${HOME}/.aliases.local ]; then touch ${HOME}/.aliases.local; fi
	if [ ! -e ${HOME}/.zshenv.local ]; then touch ${HOME}/.zshenv.local; fi
	if [ ! -e ${HOME}/.zshrc.local ]; then touch ${HOME}/.zshrc.local; fi

.PHONY: uninstall
uninstall:
	@stow -D . -t "$(HOME)" -v

.PHONY:	uninstall-tmux
uninstall-tmux:
	$(info --> Uninstall Tmux plugins)
	[[ -d ${HOME}/.tmux/plugins ]] && rm -rf ${HOME}/.tmux/plugins
.PHONY:	uninstall-vim
uninstall-vim:
	$(info --> Uninstall Vim plugins)
	#@[[ -d ${HOME}/.vim/biundle ]] && rm -rf ${HOME}/.vim/biundle
	@[[ -e /usr/share/fonts/PowerlineSymbols.otf ]] && rm -rf /usr/share/fonts/PowerlineSymbols.otf
	@[[ -d /etc/fonts/conf.d/10-powerline-symbols.conf ]] && rm -rf /etc/fonts/conf.d/10-powerline-symbols.conf

define check_package
@which $(package) >/dev/null ||\
{ echo "Missing package '$(package)'"; exit 1; }


endef

.PHONY: requirements
requirements:
	$(foreach package, $(PACKAGES), $(check_package))

