.PHONY: all install symlinks

all: install symlinks

install:
	@echo "Installing dependencies..."
	./install.sh

symlinks:
	@echo "Setting up symlinks..."
	./setup_symlinks.sh
