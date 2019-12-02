# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/slackhq/nebula"
EGO_VENDOR=(
		"github.com/fhs/gompd v2.0.2"
		"github.com/anmitsu/go-shlex v0.0.0-20161002113705-648efa622239"
		"github.com/armon/go-radix v1.0.0"
		"github.com/cyberdelia/go-metrics-graphite v0.0.0-20161219230853-39f87cc3b432"
		"github.com/flynn/go-shlex v0.0.0-20150515145356-3f9db97f8568 // indirect"
		"github.com/flynn/noise v0.0.0-20180327030543-2492fe189ae6"
		"github.com/golang/protobuf v1.3.1"
		"github.com/imdario/mergo v0.3.7"
		"github.com/konsorten/go-windows-terminal-sequences v1.0.2 // indirect"
		"github.com/kr/pretty v0.1.0 // indirect"
		"github.com/miekg/dns v1.1.12"
		"github.com/nbrownus/go-metrics-prometheus v0.0.0-20180622211546-6e6d5173d99c"
		"github.com/prometheus/client_golang v0.9.3"
		"github.com/prometheus/common v0.4.1 // indirect"
		"github.com/prometheus/procfs v0.0.0-20190523193104-a7aeb8df3389 // indirect"
		"github.com/rcrowley/go-metrics v0.0.0-20181016184325-3113b8401b8a"
		"github.com/sirupsen/logrus v1.4.2"
		"github.com/songgao/water v0.0.0-20190402020555-6ad6edefb15c"
		"github.com/stretchr/testify v1.3.0"
		"github.com/vishvananda/netlink v1.0.1-0.20190522153524-00009fb8606a"
		"github.com/vishvananda/netns v0.0.0-20180720170159-13995c7128cc // indirect"
		"golang.org/x/crypto v0.0.0-20190513172903-22d7a77e9e5f"
		"golang.org/x/net v0.0.0-20190522155817-f3200d17e092"
		"golang.org/x/sync v0.0.0-20190423024810-112230192c58 // indirect"
		"golang.org/x/sys v0.0.0-20190524152521-dbbf3f1254d4"
		"gopkg.in/check.v1 v1.0.0-20180628173108-788fd7840127 // indirect"
		"gopkg.in/yaml.v2 v2.2.2"
)

inherit golang-build golang-vcs user

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
	eapply_user
}

src_compile() {
	cd ${WORKDIR}/${P}/src/${EGO_PN}/
	export BUILD_NUMBER="dev+$(date -u '+%Y%m%d%H%M%S')"
	export GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath):${EGO_STORE_DIR}"
	export GO111MODULE=off GOARCH=amd64 GOOS=linux
	mkdir -p build/linux
	go build -o build/linux/nebula -ldflags "-X main.Build=${BUILD_NUMBER}" ./cmd/nebula
	go build -o build/linux/nebula-cert -ldflags "-X main.Build=${BUILD_NUMBER}" ./cmd/nebula-cert
}

src_install() {
	cd ${WORKDIR}/${P}/src/${EGO_PN}/
	dobin build/linux/nebula
	dobin build/linux/nebula-cert

	insinto /etc/${PN}
	ls -al examples/
	doins examples/config.yaml
	newinitd ${FILESDIR}/nebula.initd nebula
}
