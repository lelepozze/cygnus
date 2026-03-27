# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI="8"

inherit desktop

DESCRIPTION="A simple, TV-friendly, gamepad-navigable frontend for the Lutris game launcher on Linux."
HOMEPAGE="https://github.com/andrew-ld/lutris-gamepad-ui"
SRC_URI="https://github.com/andrew-ld/lutris-gamepad-ui/archive/refs/tags/v${PV}.tar.gz"
RELEASE_FOLDER="${S}/release/linux-unpacked"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

#RDEPEND="
#
#"

BDEPEND="
	net-libs/nodejs[npm]
	sys-fs/squashfs-tools[zstd]
"

src_unpack() {
	unpack v${PV}.tar.gz
}

src_prepare() {
	default
}

src_configure() {
	npm i
	npm audit fix

}

src_compile() {
	npm run build
}

src_install() {
	newicon ${S}/src_frontend/resources/icon.svg lutris-gamepad-ui.svg
	
	make_desktop_entry "/opt/bin/lutris-gamepad-ui --ozone-platform=x11" "Lutris Gamepad UI" "/usr/share/pixmaps/lutris-gamepad-ui.svg" Game
	
	local DESTDIR="/opt/lutris-gamepad-ui"

	exeinto "${DESTDIR}"
	doexe ${RELEASE_FOLDER}/chrome-sandbox ${RELEASE_FOLDER}/chrome_crashpad_handler ${RELEASE_FOLDER}/*.so ${RELEASE_FOLDER}/*.so.1 ${RELEASE_FOLDER}/lutris-gamepad-ui ${RELEASE_FOLDER}/*.pak ${RELEASE_FOLDER}/*.dat ${RELEASE_FOLDER}/*.txt ${RELEASE_FOLDER}/*.html ${RELEASE_FOLDER}/*.bin ${RELEASE_FOLDER}/*.json
	insinto "${DESTDIR}"
	insopts -m0755
	doins -r ${RELEASE_FOLDER}/locales ${RELEASE_FOLDER}/resources
	
	# Chrome-sandbox requires the setuid bit to be specifically set.
	# see https://github.com/electron/electron/issues/17972
	fperms 4755 "${DESTDIR}"/chrome-sandbox
	
	dosym "${DESTDIR}"/lutris-gamepad-ui /opt/bin/lutris-gamepad-ui
}








