PUBLIC_DIR = public
HUGO_THEME = hugo_theme_pickles

server:
	hugo server -D -t $(HUGO_THEME)

build:
	hugo -t $(HUGO_THEME)

publish: build
	git add $(PUBLIC_DIR)
	git commit -m "Rebuilding site `date --iso-8601=seconds`"
	git subtree push -P $(PUBLIC_DIR) origin master

.PHONY: server build publish
