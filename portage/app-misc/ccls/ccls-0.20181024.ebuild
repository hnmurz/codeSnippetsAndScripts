# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit cmake-utils

DESCRIPTION="ccls, which originates from cquery, is a C/C++/Objective-C language server."
HOMEPAGE="https://github.com/MaskRay/ccls"
SRC_URI="https://github.com/MaskRay/ccls/archive/0.20181024.tar.gz"

LICENSE="Apache License"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-libs/rapidjson
	sys-devel/gcc
	dev-util/cmake
"
RDEPEND="${DEPEND}"

CMAKE_USE_DIR="${WORKDIR}/${P}"

src_prepare(){
	cmake-utils_src_prepare
}

src_configure(){
	local mycmakeargs=(
		-H.
		-BRelease
		-DSYSTEM_CLANG="On"
		-DCMAKE_PREFIX_PATH="/usr/lib/llvm/6"
		-DLLVM_ENABLE_RTTI="on"
	)
	cmake-utils_src_configure
}

src_compile(){
	cmake-utils_src_compile
}

src_install(){
	cmake-utils_src_install
}
