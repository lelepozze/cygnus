# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit wrapper

DESCRIPTION="Utility for mass-downloading synced lyrics for an offline music library"
HOMEPAGE="https://github.com/tranxuanthang/lrcget"
SRC_URI="https://github.com/tranxuanthang/lrcget/releases/download/${PV}/LRCGET_${PV}_amd64.AppImage -> ${P}.AppImage"

S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="sys-fs/fuse:0"

src_unpack() {
	:
}

src_install() {
	insinto "/opt/${PN}"
	newins "${DISTDIR}/${A}" "${P}.AppImage"
	fperms 0755 "/opt/${PN}/${P}.AppImage"

	make_wrapper "${PN}" "/opt/${PN}/${P}.AppImage"
}
