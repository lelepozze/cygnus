# cygnus overlay

Daniele Pozzebon's personal Gentoo Linux overlay.

## Installing

Edit the /etc/portage/repos.conf/eselect-repo.conf file with

```
[cygnus]
location = /var/db/repos/cygnus
sync-type = git
sync-uri = https://github.com/lelepozze/cygnus.git
```

And sync the repo

```
emaint sync -r cygnus
```
