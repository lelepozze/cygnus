# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Some plymouth themes for Gentoo Linux"
HOMEPAGE="https://github.com/lelepozze/gentoo-plymouth"
SRC_URI="https://github.com/lelepozze/gentoo-plymouth/releases/download/${PV}/${PN}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="sys-boot/plymouth"

S="${WORKDIR}"

src_install() {
	insinto /usr/share/plymouth/themes
	doins -r spinfinity-gentoo 
	doins -r spinner-gentoo
}
