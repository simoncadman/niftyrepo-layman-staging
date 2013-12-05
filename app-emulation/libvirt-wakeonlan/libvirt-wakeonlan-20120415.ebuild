# Copyright 2013 Simon Cadman 
# $Header: $

EAPI="2"
inherit git-2 eutils

DESCRIPTION="Starts KVM instances from wake on lan packets"
HOMEPAGE="https://libvirtwol.niftiestsoftware.com"
EGIT_REPO_URI="git://github.com/simoncadman/libvirt-wakeonlan.git"
EGIT_COMMIT="9d667fbe57c0c46c423edd65a94327204f2cb138"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=">=dev-lang/python-2.6
|| ( app-emulation/libvirt[python] dev-python/libvirt-python )
dev-python/pylibpcap
"
S=${WORKDIR}/${P}

src_install() {
	einstall DESTDIR="${D}" install
}

