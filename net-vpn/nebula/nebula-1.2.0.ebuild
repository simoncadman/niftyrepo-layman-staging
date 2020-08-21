# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/slackhq/nebula"
EGO_VENDOR=(
	"github.com/anmitsu/go-shlex v0.0.0-20161002113705-648efa622239"
	"github.com/armon/go-radix v1.0.0"
	"github.com/cespare/xxhash/v2 v2.1.1 // indirect"
	"github.com/cyberdelia/go-metrics-graphite v0.0.0-20161219230853-39f87cc3b432"
	"github.com/flynn/go-shlex v0.0.0-20150515145356-3f9db97f8568 // indirect"
	"github.com/flynn/noise v0.0.0-20180327030543-2492fe189ae6"
	"github.com/golang/protobuf v1.3.2"
	"github.com/imdario/mergo v0.3.8"
	"github.com/kardianos/service v1.0.0"
	"github.com/konsorten/go-windows-terminal-sequences v1.0.2 // indirect"
	"github.com/kr/pretty v0.1.0 // indirect"
	"github.com/miekg/dns v1.1.25"
	"github.com/nbrownus/go-metrics-prometheus v0.0.0-20180622211546-6e6d5173d99c"
	"github.com/prometheus/client_golang v1.2.1"
	"github.com/prometheus/client_model v0.0.0-20191202183732-d1d2010b5bee // indirect"
	"github.com/prometheus/procfs v0.0.8 // indirect"
	"github.com/rcrowley/go-metrics v0.0.0-20190826022208-cac0b30c2563"
	"github.com/sirupsen/logrus v1.4.2"
	"github.com/songgao/water v0.0.0-20190725173103-fd331bda3f4b"
	"github.com/stretchr/testify v1.4.0"
	"github.com/vishvananda/netlink v1.0.1-0.20190522153524-00009fb8606a"
	"github.com/vishvananda/netns v0.0.0-20191106174202-0a2b9b5464df // indirect"
	"golang.org/x/crypto v0.0.0-20200220183623-bac4c82f6975"
	"golang.org/x/net v0.0.0-20191209160850-c0dbc17a3553"
	"golang.org/x/sys v0.0.0-20191210023423-ac6580df4449"
	"gopkg.in/check.v1 v1.0.0-20180628173108-788fd7840127 // indirect"
	"gopkg.in/yaml.v2 v2.2.7"
)

inherit golang-build golang-vcs user systemd

DESCRIPTION="A scalable overlay networking tool with a focus on performance, simplicity etc"
LICENSE="MIT"
KEYWORDS="amd64 x86 arm"
SLOT=0

HOMEPAGE="https://github.com/slackhq/nebula"
SRC_URI="${ARCHIVE_URI}
	${EGO_VENDOR_URI}"
SLOT="0"
IUSE=""

src_prepare() {
	cd ${WORKDIR}/${P}/src/${EGO_PN}/
	git checkout v${PV}
	sed -i 's/\/usr\/local\/bin\//\/usr\/bin\//g' examples/service_scripts/nebula.service
	eapply_user
}

src_compile() {
	cd ${WORKDIR}/${P}/src/${EGO_PN}/
	export BUILD_NUMBER="dev+$(date -u '+%Y%m%d%H%M%S')"
	export GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath):${EGO_STORE_DIR}"
	export GO111MODULE=off GOARCH=amd64 GOOS=linux
	go build -trimpath -ldflags "-X main.Build=$(BUILD_NUMBER)" -o ./nebula ./cmd/nebula
	go build -trimpath -ldflags "-X main.Build=$(BUILD_NUMBER)" -o ./nebula-cert ./cmd/nebula-cert
}

src_install() {
	cd ${WORKDIR}/${P}/src/${EGO_PN}/
	dobin nebula
	dobin nebula-cert

	insinto /etc/${PN}
	doins examples/config.yml
	newinitd ${FILESDIR}/nebula.initd nebula
	systemd_dounit examples/service_scripts/nebula.service
}
