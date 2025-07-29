# Copyright 1999-2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3

EAPI=8

DESCRIPTION="MLV Reading/Writing library"
HOMEPAGE="https://github.com/ilia3101/LibMLV"
SRC_URI="https://github.com/ilia3101/LibMLV/releases/download/raw2mlv-0.1/Linux.zip -> raw2mlv.zip"
S="${WORKDIR}"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

src_unpack() {
	unpack raw2mlv.zip
}

src_install() {
	mv ${WORKDIR}/raw2mlv.Linux ${WORKDIR}/raw2mlv
	chmod +x ${WORKDIR}/raw2mlv
	dobin raw2mlv
}
