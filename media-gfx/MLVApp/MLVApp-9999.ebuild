# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI=8

inherit git-r3 desktop qmake-utils

DESCRIPTION="All-in-one MLV processing application"
HOMEPAGE="https://mlv.app/ https://github.com/ilia3101/MLV-App"
EGIT_REPO_URI="https://github.com/ilia3101/MLV-App.git"
S="${WORKDIR}/${P}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

PATCHES=(
	"${FILESDIR}"/${P}-build.patch
)

RDEPEND="
	media-video/ffmpeg
	media-gfx/raw2mlv
	sys-fs/fuse
	x11-libs/libxkbcommon
"
BDEPEND="
	dev-qt/qtbase:6
	dev-qt/qtmultimedia:6
	dev-qt/qtsvg
	dev-libs/appstream
"

src_unpack() {
	unpack ${P}.tar.gz
}

src_prepare() {
	default
}

src_configure() {
	eqmake6 ${S}/platform/qt/MLVApp.pro
}

src_compile() {
	emake
}

src_install() {
	dobin mlvapp
	domenu ${S}/platform/qt/mlvapp.desktop
	newicon -s 512x512 ${S}/src/icon/icon.png MLVAPP.png
}
