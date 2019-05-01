PUBLIC_DIR = public
HUGO_THEME = hugo_theme_pickles

server:
	hugo server -D -t $(HUGO_THEME)

draft:
	hugo new `date '+posts/%Y/%m/draft.md'`

build:
	hugo --cleanDestinationDir -t $(HUGO_THEME)

publish: build
	git add $(PUBLIC_DIR)
	git commit -m "Rebuilding site `date --iso-8601=seconds`"
	git subtree push -P $(PUBLIC_DIR) origin master

.PHONY: server draft build publish
