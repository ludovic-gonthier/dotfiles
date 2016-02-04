install: \
	install-tpm \
	install-vundle

install-tpm:
	$(info --> Install Tmux-tpm)

install-vundle:
	$(info --> Installing Vim-Vundle)

.PHONY: \
	install \
	install-tpm \
	install-vundle
