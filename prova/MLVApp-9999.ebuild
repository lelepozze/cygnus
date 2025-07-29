# Copyright 1999-2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="All in one MagicLantern videos (MLV) processing app"
HOMEPAGE="https://amanusk.github.io/s-tui/"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ilia3101/MLV-App.git"
	EGIT_SUBMODULES=()
else
	SRC_URI="https://github.com/ilia3101/MLV-App/archive/refs/tags/QTv${PV}.zip -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

https://github.com/ilia3101/MLV-App/archive/refs/tags/QTv1.14.zip

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="stress"

RDEPEND=">=dev-lang/python-3
    >=dev-python/psutil-5.9.1[${PYTHON_USEDEP}]
    >=dev-python/urwid-2.0.1[${PYTHON_USEDEP}]
    stress? ( app-benchmarks/stress )
"

distutils_enable_tests unittest

pkg_postinst() {
	optfeature "Stress options in program menu" app-benchmarks/stress
}
