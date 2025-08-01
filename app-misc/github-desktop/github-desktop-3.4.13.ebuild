# Copyright 2019-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8


inherit desktop rpm xdg

CUSTOMNAME="linux"
DESCRIPTION="Fork of GitHub Desktop"
HOMEPAGE="https://github.com/shiftkey/desktop"
SRC_URI="https://github.com/shiftkey/desktop/releases/download/release-${PV}-linux1/GitHubDesktop-linux-x86_64-${PV}-linux1.rpm -> ${P}.rpm"
S="${WORKDIR}"

KEYWORDS="amd64"
# Electron bundles a bunch of things
LICENSE="
	MIT BSD BSD-2 BSD-4 AFL-2.1 Apache-2.0 Ms-PL GPL-2 LGPL-2.1 APSL-2
	unRAR OFL CC-BY-SA-3.0 MPL-2.0 android public-domain all-rights-reserved
"
SLOT="0"
RESTRICT="bindist mirror"

# USE flags
IUSE="alacritty"

RDEPEND="
	app-arch/rpm2targz
	>=app-accessibility/at-spi2-core-2.46.0:2
	app-crypt/libsecret
	dev-libs/expat
	dev-libs/glib
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa
	net-misc/curl
	net-print/cups
	sys-apps/dbus
	sys-libs/glibc
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/gtk+:3
	x11-libs/libdrm
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libxkbcommon
	x11-libs/libXrandr
	x11-libs/pango
	alacritty? ( x11-terms/alacritty )
"

QA_PREBUILT="opt/github-desktop/*"



src_configure() {
	default
}

src_install() {
	for size in {32,64,128,256,512,1024}; do
		doicon -s ${size} "usr/share/icons/hicolor/${size}x${size}/apps/github-desktop.png"
	done

	domenu usr/share/applications/github-desktop.desktop

	local DESTDIR="/opt/github-desktop"
	pushd "usr/lib/github-desktop" || die

	exeinto "${DESTDIR}"
	doexe chrome-sandbox chrome_crashpad_handler github-desktop *.so*

	insinto "${DESTDIR}"
	doins *.pak *.bin *.json *.dat
	insopts -m0755
	doins -r locales resources

	# Chrome-sandbox requires the setuid bit to be specifically set.
	# see https://github.com/electron/electron/issues/17972
	fperms 4755 "${DESTDIR}"/chrome-sandbox

	dosym "${DESTDIR}"/github-desktop /opt/bin/github-desktop
	popd || die
}
