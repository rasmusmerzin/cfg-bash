symlink:
	ln -sfv "${PWD}/bashrc" "${HOME}/.bashrc"
	ln -sfv ".bashrc" "${HOME}/.bash_profile"

clean:
	rm -f "${HOME}/.bashrc"
	rm -f "${HOME}/.bash_profile"

.PHONY: symlink clean
