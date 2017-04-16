TERMUX_PKG_HOMEPAGE=https://www.terraform.io
TERMUX_PKG_DESCRIPTION="Tool for building, changing, and combining infrastructure safely and efficiently"
TERMUX_PKG_VERSION=0.9.3
TERMUX_PKG_SRCURL=https://github.com/hashicorp/terraform/archive/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=de57ba63f0314ba4e21818f048551a22afe61662bd72b3c81b01a47284fcaf3d
TERMUX_PKG_FOLDERNAME=terraform-${TERMUX_PKG_VERSION}

termux_step_make(){
	termux_setup_golang

	export GOPATH="$(pwd)"
	export PATH="$GOPATH/bin:$PATH"

	mkdir -p src/github.com/hashicorp/terraform
	cp -R $TERMUX_PKG_SRCDIR/* src/github.com/hashicorp/terraform

	cd src/github.com/hashicorp/terraform

	# Use only the generate target from the Makefile, because gox doesn't support android/arm64
	GOOS= GOARCH= make generate
	go build -o bin/terraform
}
#
termux_step_make_install() {
	cp src/github.com/hashicorp/terraform/bin/terraform $TERMUX_PREFIX/bin/
}
