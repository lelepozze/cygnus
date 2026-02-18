# Copyright 1999-2026 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3

EAPI=8

inherit go-module git-r3

DESCRIPTION="A lightweight Subsonic TUI music player built in Go with scrobbling support."
HOMEPAGE="https://github.com/MattiaPun/SubTUI"
EGIT_REPO_URI="https://github.com/MattiaPun/SubTUI"

RESTRICT="network-sandbox"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="
    media-video/mpv
"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

#src_prepare() {
#	default
#}

src_compile() {
	ego build .
}

src_install() {
    dobin SubTUI
}

