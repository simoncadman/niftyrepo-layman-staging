# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

EGIT_REPO_URI="https://github.com/Realtek-OpenSource/android_hardware_realtek.git"
EGIT_COMMIT="e58b611f34f2f5ff57bb0d8cdf1b2e4751e3ccbd"
inherit git-r3

DESCRIPTION="Firmware for rtl8761b bluetooth adapter"
HOMEPAGE="https://github.com/Realtek-OpenSource/android_hardware_realtek/"

LICENSE="no-source-code"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

S=${WORKDIR}/${MY_P}

src_install() {
	insinto /lib/firmware/rtl_bt
	cd ${PF}/bt/rtkbt/Firmware/BT/
	mv rtl8761b_config rtl8761b_config.bin
	mv rtl8761b_fw rtl8761b_fw.bin
	doins rtl8761b_{config,fw}.bin
}
