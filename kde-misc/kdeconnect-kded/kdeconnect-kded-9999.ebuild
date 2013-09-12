# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
 
EAPI=5
 
KDE_MINIMAL="4.10"
inherit kde4-base git-2
 
DESCRIPTION="KDE Connect: Fusion your devices with KDE"
HOMEPAGE="http://albertvaka.wordpress.com/2013/08/05/introducing-kde-connect/"
 
EGIT_REPO_URI="git://anongit.kde.org/kdeconnect-kde"
 
LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="
"
 
RDEPEND="${DEPEND}
net-dns/avahi
"
 
PATCHES=(
)
 
S="${WORKDIR}/${PN}"
