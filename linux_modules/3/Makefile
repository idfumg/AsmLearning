obj-m += mydriver.o

KDIR=/usr/lib/modules/$(shell uname -r)/build/

all:
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules

clean:
	rm -fr *.o *.ko *.mod.* *.symvers *.order *~
