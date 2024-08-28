# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Terminal UI stress test and monitoring tool"
HOMEPAGE="https://github.com/amanusk/s-tui"
SRC_URI="https://github.com/amanusk/s-tui/archive/v${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="stress"

RDEPEND=">=dev-lang/python-3
    dev-python/urwid
    dev-python/psutil
    dev-python/setuptools
    stress? ( app-benchmarks/stress )"
DEPEND="${RDEPEND}"

src_prepare() {
    eapply_user
    cd "${WORKDIR}/${PN}-${PR}"
    rm Makefile
}

src_install() {
    python setup.py install --root="${D}" --optimize=1
}
