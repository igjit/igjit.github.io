FROM rocker/tidyverse:4.1.2

RUN installGithub.r \
    r-lib/hugodown \
 && rm -rf /tmp/downloaded_packages/
