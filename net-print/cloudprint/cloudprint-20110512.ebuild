# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit git eutils

DESCRIPTION="Google cloud print server"
HOMEPAGE="https://github.com/armooo/cloudprint"
EGIT_REPO_URI="git://github.com/armooo/cloudprint"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=">=dev-lang/python-2.6
dev-python/pycups"
S=${WORKDIR}/${P}

src_unpack() {
    git_src_unpack ${A}
    cd "${S}"
    git checkout 620e490f1a1a82e42f5c3b603517e64ed2919654
    epatch "${FILESDIR}"/cloudprint-20110512.patch
}

src_install() {
	mkdir -p ${D}/usr/lib/
	mkdir -p ${D}/var/lib/cloudprint
	mkdir -p ${D}/var/log
	touch ${D}/var/log/cloudprint.log
	chown -R nobody:nobody ${D}/var/lib/cloudprint ${D}/var/log/cloudprint.log
	chown nobody:nobody ${D}/var/log/cloudprint.log
	mkdir -p ${D}/etc/init.d/
	cp "${FILESDIR}"/cloudprint ${D}/etc/init.d/
	mv cloudprint ${D}/usr/lib/cloudprint/
}

pkg_postinst() {
	elog
	elog "Before starting the service, you must first run /etc/init.d/cloudprint setup to sign in to your google account. "
        elog "To get cloudprint to start automatically, you can add "
        elog "it to the default run level, by running this command as root:"
        elog
        elog "rc-update add cloudprint default"
}

