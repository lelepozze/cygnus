# Copyright 1999-2026 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3

EAPI=8

inherit qmake-utils desktop

DESCRIPTION="All in one MagicLantern videos (MLV) processing app"
HOMEPAGE="https://github.com/ilia3101/MLV-App"
SRC_URI="https://github.com/ilia3101/MLV-App/archive/refs/tags/Qtv${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/MLV-App-Qtv${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

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
