.PHONY: all install help

all: help

d := ${shell \
	if [ "$$(whoami)" = root ]; then \
		echo /usr/local; \
	else \
		echo ~/.rclip ; \
	fi \
}
e := $d/bin/rclip
p := ${shell \
	if [ "$$(whoami)" = root ]; then \
		exit ;\
	fi ;\
	case "$$SHELL" in \
	zsh | */bin/zsh) \
		if [ -f ~/.zprofile ]; then \
			echo ~/.zprofile ;\
		else \
			echo ~/.profile ;\
		fi \
		;; \
	bash | */bin/bash) \
		if [ -f ~/.bash_profile ]; then \
			echo ~/.bash_profile ; \
		else \
			echo ~/.profile ; \
		fi \
		;; \
	*) \
		echo ~/.profile \
	;; \
	esac \
}

help:
	@echo "Run 'make install' to install."
	@echo "To be installed under '$d', and the executable at '$e'."
	@[ -z '$p' ] || echo "PATH environment will be set in '$p'."

install:
	mkdir -p '$d/bin'
	cp rclip '$d/bin/'
	if [ -n '$p' ] && [ "$$(which rclip)" != '$e' ]; then \
		( \
			set -e ;\
			echo ;\
			echo 'PATH="$d/bin:$$PATH"' ;\
		) >>'$p' ;\
	fi
