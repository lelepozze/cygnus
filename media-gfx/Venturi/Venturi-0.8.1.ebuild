# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI="8"
RUST_MIN_VER="1.88"

[[ ${PV} == *9999* ]] && inherit git-r3
inherit cargo rust desktop

DESCRIPTION="Linux-first, performance oriented minimal video editor"
HOMEPAGE="https://venturivideo.github.io/Venturi/"
if [[ ${PV} != *9999* ]]; then
    SRC_URI="https://github.com/VenturiVideo/Venturi/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
else
    EGIT_REPO_URI="https://github.com/VenturiVideo/Venturi.git"
fi
S="${WORKDIR}/${P}"

LICENSE="GPL-3.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

# Maybe it's not needed, but for now I use RESTRICT=network-sandbox.
# RESTRICT="network-sandbox"

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
    if [[ ${PV} != *9999* ]]; then
        unpack ${P}.tar.gz
        cargo_src_unpack
    else
        git-r3_src_unpack
        cargo_live_src_unpack
    fi

}

src_configure() {
    export RUSTUP_TOOLCHAIN=stable
    export CARGO_TARGET_DIR=target
    cargo_src_configure -p vv-app --release --frozen
}

src_compile() {
    export RUSTUP_TOOLCHAIN=stable
    export CARGO_TARGET_DIR=target
    cargo build
}

src_install() {
    make_desktop_entry --eapi9 "vv-app %f" -n "Venturi" -c "AudioVideo;Video;AudioVideoEditing" -C "Video editor" -i "venturi-video" -d "venturi" -e "Terminal=false" -e "MimeType=application/x-venturi-project;"
    dobin ${S}/target/release/vv-app
    for size in {16,24,32,48,64,128,256,512}; do
        doicon -s ${size} ${S}/media/icons/linux/hicolor/${size}x${size}/apps/venturi-video.png
    done
    doicon -s scalable ${S}/media/icons/linux/hicolor/scalable/apps/venturi-video.svg
}
