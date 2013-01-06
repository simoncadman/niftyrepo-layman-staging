# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Prevents fsync"
HOMEPAGE="http://flamingspork.com/projects/libeatmydata/"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
SRC_URI="http://niftyrepo.niftiestsoftware.com/files/libeatmydata-${PV}.tar.bz2"
S=${WORKDIR}/${P}

src_install() {
	mkdir -p ${D}/usr/bin/ ${D}/usr/lib/
	cp "${FILESDIR}"/eatmydata ${D}/usr/bin/
	mv ${S}/libeatmydata.so* ${D}/usr/lib/
}

pkg_postinst() {
	elog
	elog "To use, run programs via the eatmydata command eg:"
	elog "eatmydata firefox"
}

