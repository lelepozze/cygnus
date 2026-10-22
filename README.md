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

If you are using app-portage/pycargoebuild for create a list of crates for
rust packages, you must assure that inside the Cargo.toml there is a section present, like this one

```
[package]
name = "package-name"
version = "package-version"
```

that are used for create the ebuild file.

If you want, you can use it to create only the list of the crates to insert into the ebuild, using the -C flag.

