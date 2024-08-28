# cygnus overlay

Daniele Pozzebon's personal Gentoo Linux overlay.

## Installing

Edit the /etc/portage/repos.conf/custom.conf file with

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


## REMIND ME

In order to make the Manifest file, you must run

```
sudo PORTDIR_OVERLAY="/var/db/repos/cygnus" GENTOO_MIRRORS="" ebuild ./xxxxxx-n.n.n.ebuild manifest clean unpack
```

And if you modify the .ebuild file, you must re-run this command
