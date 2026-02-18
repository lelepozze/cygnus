# Copyright 1999-2026 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3

EAPI=8

inherit go-module

DESCRIPTION="A lightweight Subsonic TUI music player built in Go with scrobbling support."
HOMEPAGE="https://github.com/MattiaPun/SubTUI"
SRC_URI="https://github.com/MattiaPun/SubTUI/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/SubTUI-${PV}"

RESTRICT="network-sandbox"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
    media-video/mpv
"

src_unpack() {
	unpack ${P}.tar.gz
	go-module_live_vendor
}

#src_prepare() {
#	default
#}

src_compile() {
	ego build .
}

src_install() {
    dobin subtui
}

