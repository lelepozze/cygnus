# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2


EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools

inherit git-r3 distutils-r1

DESCRIPTION="Python script to simulate the display from 'The Matrix' in terminal."
HOMEPAGE="https://github.com/will8211/unimatrix"
EGIT_REPO_URI="https://github.com/will8211/unimatrix.git"

LICENSE="GPL-3.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=""
DEPEND="${RDEPEND}"

rc_install() {
   einstalldocs
}

#distutils_enable_tests pytest


















