# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI="8"

inherit desktop

DESCRIPTION="A simple, TV-friendly, gamepad-navigable frontend for the Lutris game launcher on Linux."
HOMEPAGE="https://github.com/andrew-ld/lutris-gamepad-ui"
SRC_URI="https://github.com/andrew-ld/lutris-gamepad-ui/archive/refs/tags/${PV}.tar.gz"
BUILD_FOLDER="${S}/dist/linux-unpacked"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="network-sandbox"

#RDEPEND="
#
#"

BDEPEND="
	net-libs/nodejs[npm]
"

src_unpack() {
	unpack ${PV}.tar.gz
}

src_prepare() {
	npm i
	npm audit fix
	default
}

src_compile() {

	npm run build
}

src_install() {
	newicon ${S}/src/resources/icon.svg lutris-gamepad-ui.svg
	
	make_desktop_entry "/opt/bin/lutris-gamepad-ui --gtk-version=3" "Lutris Gamepad UI" "/usr/share/pixmaps/lutris-gamepad-ui.svg" Game
	
	local DESTDIR="/opt/lutris-gamepad-ui"

	exeinto "${DESTDIR}"
	doexe ${BUILD_FOLDER}/chrome-sandbox ${BUILD_FOLDER}/chrome_crashpad_handler ${BUILD_FOLDER}/*.so ${BUILD_FOLDER}/*.so.1 ${BUILD_FOLDER}/lutris-gamepad-ui ${BUILD_FOLDER}/*.pak ${BUILD_FOLDER}/*.dat  ${BUILD_FOLDER}/*.txt ${BUILD_FOLDER}/*.html ${BUILD_FOLDER}/*.bin ${BUILD_FOLDER}/*.json
	insinto "${DESTDIR}"
	insopts -m0755
	doins -r ${BUILD_FOLDER}/locales ${BUILD_FOLDER}/resources
	
	# Chrome-sandbox requires the setuid bit to be specifically set.
	# see https://github.com/electron/electron/issues/17972
	fperms 4755 "${DESTDIR}"/chrome-sandbox
	
	dosym "${DESTDIR}"/lutris-gamepad-ui /opt/bin/lutris-gamepad-ui
}








