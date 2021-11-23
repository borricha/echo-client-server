.PHONY : echo-client echo-server clean install uninstall android-install android-uninstall

all: echo-client echo-server

echo-client:
	cd echo-client; make; cd ..

echo-server:
	cd echo-server; make; cd ..


clean:
	cd echo-client; make clean; cd ..
	cd echo-server; make clean; cd ..

install:
	sudo cp bin/tc /usr/sbin
	sudo cp bin/ts /usr/sbin
	sudo cp bin/uc /usr/sbin
	sudo cp bin/us /usr/sbin

uninstall:
	sudo rm /usr/sbin/tc /usr/sbin/ts /usr/sbin/uc /usr/sbin/us

android-install:
	adb push bin/tc bin/ts bin/uc bin/us /data/local/tmp
	adb exec-out "su -c mount -o rw,remount /system"
	adb exec-out "su -c cp /data/local/tmp/tc /data/local/tmp/ts /data/local/tmp/uc /data/local/tmp/us /system/xbin"
	adb exec-out "su -c chmod 755 system/xbin/tc"
	adb exec-out "su -c chmod 755 system/xbin/ts"
	adb exec-out "su -c chmod 755 system/xbin/uc"
	adb exec-out "su -c chmod 755 system/xbin/us"
	adb exec-out "su -c mount -o ro,remount /system"
	adb exec-out "su -c rm /data/local/tmp/tc /data/local/tmp/ts /data/local/tmp/uc /data/local/tmp/us"

android-uninstall:
	su -c mount -o rw,remount /system
	su -c rm /system/xbin/tc /system/xbin/ts /system/xbin/uc /system/xbin/us
	su -c mount -o ro,remount /system
