# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI="8"
RUST_MIN_VER="1.88"

inherit git-r3 cargo rust desktop

DESCRIPTION="Linux-first, performance oriented minimal video editor"
HOMEPAGE="https://venturivideo.github.io/Venturi/"
EGIT_REPO_URI="https://github.com/VenturiVideo/Venturi.git"
S="${WORKDIR}/${P}"

LICENSE="GPL-3.0"
SLOT="0"

RDEPEND="
    media-video/ffmpeg
    media-libs/alsa-lib
    media-libs/mesa[wayland]
"
BDEPEND="
    llvm-core/clang
    dev-libs/wayland
    x11-libs/libxkbcommon
    x11-libs/libX11
    media-libs/vulkan-loader
"

src_unpack() {
    git-r3_src_unpack
    cargo_live_src_unpack

}

src_configure() {
    cargo_src_configure -p vv-app --frozen
}

src_compile() {
    cargo_src_compile
}

src_install() {
    cargo_src_install --path ${S}/target/release/vv-app
    make_desktop_entry --eapi9 "vv-app %f" -n "Venturi" -c "AudioVideo;Video;AudioVideoEditing" -C "Video editor" -i "venturi-video" -d "venturi" -e "Terminal=false" -e "MimeType=application/x-venturi-project;"
    for size in {16,24,32,48,64,128,256,512}; do
        doicon -s ${size} ${S}/media/icons/linux/hicolor/${size}x${size}/apps/venturi-video.png
    done
    doicon -s scalable ${S}/media/icons/linux/hicolor/scalable/apps/venturi-video.svg
}
