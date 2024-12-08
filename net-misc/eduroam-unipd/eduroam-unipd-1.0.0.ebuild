# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Python script to connect to WiFi eduroam from 'University of Padua'."
HOMEPAGE="https://cat.eduroam.org/"
SRC_URI="https://cat.eduroam.org/user/API.php?action=downloadInstaller&lang=it&profile=9199&device=linux&generatedfor=user&openroaming=0 -> ${PN}.py"
S="${WORKDIR}"

LICENSE="GPL-3.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=""
DEPEND="${RDEPEND}"

rc_install() {
   einstalldocs
}

#distutils_enable_tests pytest


















