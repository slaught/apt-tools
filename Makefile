
BIN=apt-update-local
CONFIG=local.list
PACKAGES=Packages.gz


DCH=dch --no-auto-nmu --distribution stable 

all: build

build: $(PACKAGES)

$(PACKAGES):
	cat /dev/null |gzip -9c > $@

install: build
	@install -m 755 $(BIN) $(DESTDIR)/usr/sbin
	@install -m 755 apt-list $(DESTDIR)/usr/sbin
	@install -m 644 $(CONFIG) $(DESTDIR)/etc/apt/sources.list.d
	@install -m 644 $(PACKAGES) $(DESTDIR)/var/local/apt-packages


changelog:
ifndef VERSION
	$(DCH)  -i
else
	$(DCH) -v $(VERSION)
endif

clean:
	-rm Packages.gz
	-rm debian/stamp-makefile-*
  

deb:
	dpkg-buildpackage -us -uc -rfakeroot
