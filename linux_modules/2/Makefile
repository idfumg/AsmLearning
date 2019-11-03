obj-m += hello.o

KDIR=/usr/lib/modules/4.19.59-1-MANJARO/build/

all:
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules

clean:
	rm -fr *.o *.ko *.mod.* *.symvers *.order
