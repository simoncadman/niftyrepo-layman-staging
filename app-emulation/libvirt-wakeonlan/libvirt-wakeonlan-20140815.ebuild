# Copyright 2013 Simon Cadman 
# $Header: $

EAPI="2"
inherit git-2 eutils

DESCRIPTION="Starts KVM instances from wake on lan packets"
HOMEPAGE="https://lvwol.niftiestsoftware.com"
EGIT_REPO_URI="git://github.com/simoncadman/libvirt-wakeonlan.git"
EGIT_COMMIT="a28782b6e690f1ba2eaefcc683befde3164206a4"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x64 ~amd64-fbsd ~x86-fbsd"
IUSE=""
DEPEND=">=dev-lang/python-2.6
|| ( app-emulation/libvirt[python] dev-python/libvirt-python )
dev-python/pylibpcap
"
S=${WORKDIR}/${P}

src_install() {
	einstall DESTDIR="${D}" install
}

