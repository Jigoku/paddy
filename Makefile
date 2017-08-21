APP_NAME=paddy_example
APP_VERSION=0.1
LOVE_VERSION=0.10.2

build setup:
	mkdir build
	cd build

all:portable

portable:
	zip -9 -q -r build/$(APP_NAME)-$(APP_VERSION).love . -x \*.git* \build

clean:
	rm -rf build/
