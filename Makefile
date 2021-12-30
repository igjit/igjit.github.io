PUBLIC_DIR = docs
HUGO_THEME = hugo_theme_pickles

RMDS = $(wildcard content/posts/*/*/*.Rmd)
MDS = $(patsubst %.Rmd,%.md,$(RMDS))

mds: $(MDS)

%.md: %.Rmd
	docker-compose run --rm -u $(shell id -u $(USER)) rmd R -e 'rmarkdown::render("$^")'

server:
	hugo server -D -t $(HUGO_THEME)

draft:
	hugo new `date '+posts/%Y/%m/draft.md'`

build:
	hugo --cleanDestinationDir -t $(HUGO_THEME)

publish: build
	git add $(PUBLIC_DIR)
	git commit -m "Rebuilding site `date --iso-8601=seconds`"
	git push origin master

.PHONY: server draft build publish
