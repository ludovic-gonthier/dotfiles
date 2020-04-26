SHELL := /bin/bash

define backup_file
@if [ -e $(1) ]; then mv $(1) $(1).bck; fi
endef

.PHONY: help
help:
	@grep -E '^[a-zA-Z1-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN { FS = ":.*?## " }; { printf "\033[36m%-30s\033[0m %s\n", $$1, $$2 }'

.PHONY: install
install: install-prerequisites \
	install-files \
	install-git \
	install-vim \
	install-tmux \
	install-fonts \
	install-shell \
	replace-capslock-by-escape \

.PHONY: install-files
install-files:
	@echo ┌ DOTFILES - Instalation start
	@echo ├── Backup files
	$(call backup_file, ${HOME}/.profile)
	$(call backup_file, ${HOME}/.zshrc)
	@echo ├── Install files
	stow -S -R . -t "${HOME}" -v
	@echo └ DOTFILES   - Installation complete

.PHONY: uninstall-files
uninstall-files:
	@echo ┌ DOTFILES - Instalation start
	@echo ├── Backup files
	$(call backup_file, ${HOME}/.profile)
	$(call backup_file, ${HOME}/.zshrc)
	@echo ├── unInstall files
	stow -D . -t "${HOME}" -v
	@echo └ DOTFILES   - Uninstallation complete

.PHONY: install-fonts
install-fonts:
	@wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
	@sudo mv PowerlineSymbols.otf /usr/share/fonts/
	@sudo fc-cache -vf
	@sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/

.PHONY: install-git
install-git:
	@zsh ./install-scripts/git.sh

.PHONY: install-prerequisites
install-prerequisites:
	@echo ┌ PREREQUISITES - Instalation start
	@echo ├── Prerequisites direcotories
	@mkdir -p ${HOME}/src ${HOME}/bin ${HOME}/share
	@sudo chown ${USERNAME}:${USERNAME} -R ${HOME}/src ${HOME}/bin ${HOME}/share
	@echo ├── Prerequisites for DOTFiles
	@sudo apt-get install -y -q stow git zsh python3-pip autoconf zlib1g-dev
	@echo └ PREREQUISITES  - Installation complete

.PHONY: install-shell
install-shell:
	@zsh ./install-scripts/shell.sh

.PHONY: install-tmux
install-tmux:
	@zsh ./install-scripts/tmux.sh

.PHONY: install-vim
install-vim:
	@zsh ./install-scripts/vim.sh

.PHONY: install-cpp-environment
install-cpp-environment:
	@sudo apt-get update
	@sudo apt-get install cmake clang-format-10 clangd-10
	@pip install conan
	@sudo update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-10 100
	@sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-10 100

.PHONY: replace-capslock-by-escape
replace-capslock-by-escape:
	@dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:escape']"
.PHONY: uninstall
uninstall: uninstall-tmux \
	uninstall-vim
	@stow -D . -t "$(HOME)" -v

.PHONY: uninstall-tmux
uninstall-tmux:
	$(info --> Uninstall Tmux plugins)
	[[ -d ${HOME}/.tmux/plugins ]] && rm -rf ${HOME}/.tmux/plugins
	.PHONY: uninstall-vim
uninstall-vim:
	$(info --> Uninstall Vim plugins)
	@[[ -d ${HOME}/.vim/bundle ]] && rm -rf ${HOME}/.vim/bundle
	@[[ -e /usr/share/fonts/PowerlineSymbols.otf ]] && rm -rf /usr/share/fonts/PowerlineSymbols.otf
	@[[ -d /etc/fonts/conf.d/10-powerline-symbols.conf ]] && rm -rf /etc/fonts/conf.d/10-powerline-symbols.conf
