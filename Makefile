SHELL := /bin/bash

define backup_file
	@if [ -e $(1) ]; then mv $(1) $(1).bck; fi
endef

.PHONY: install 
install: install-prerequisites \
	install-vim \
	install-tmux \
	install-fonts \
	install-oh-my-zsh \
	install-files \
	configure-vim \

.PHONY: install-files
install-files:
	@echo ┌ DOTFILES - Instalation start
	@echo ├── Backup files
	$(call backup_file, ${HOME}/.profile)
	$(call backup_file, ${HOME}/.zshrc)
	@echo ├── Install files
	stow -S -R . -t "${HOME}" -v
	@echo └ DOTFILES   - Installation complete

.PHONY: install-prerequisites 
install-prerequisites:
	@echo ┌ PREREQUISITES - Instalation start
	@echo ├── Prerequisites direcotories
	@mkdir -p ${HOME}/src ${HOME}/bin ${HOME}/share/man/man1
	@sudo chown ${USERNAME}:${USERNAME} -R ${HOME}/src ${HOME}/bin ${HOME}/share/man/man1
	@echo ├── Prerequisites for DOTFiles
	@sudo apt-get install -y -q stow git zsh python-pip
	@echo ├── Prerequisites for TMUX
	@sudo apt-get install -y -q libevent-dev libncurses-dev pkg-config autoconf
	@echo ├── Set default TERM to zsh
	@chsh -s /bin/zsh
	@echo └ PREREQUISITES  - Installation complete

.PHONY: install-tmux 
install-tmux:
	@zsh ./install-scripts/tmux.sh

.PHONY: install-vim
install-vim:
	@zsh ./install-scripts/vim.sh

.PHONY: install-fonts
install-fonts:
	@wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
	@sudo mv PowerlineSymbols.otf /usr/share/fonts/
	@sudo fc-cache -vf
	@sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/

.PHONY: install-oh-my-zsh
install-oh-my-zsh:
	@zsh ./install-scripts/oh-my-zsh.sh

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
