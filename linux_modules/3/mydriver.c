#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/fs.h>
#include <linux/cdev.h> // char driver
#include <linux/semaphore.h>
#include <asm/uaccess.h> // from/to userspace/kernelspace

#define DEVICE_NAME "mydevice"

struct fake_device {
    char data[100];
    struct semaphore sem;
} virtual_device;

struct cdev* mycdev;
int major_number;
int ret;
dev_t dev_num;

int device_open(struct inode* inode, struct file* filep)
{
    if (down_interruptible(&virtual_device.sem) != 0) {
        printk(KERN_ALERT "mydriver: could not lock device during open");
        return -1;
    }

    printk(KERN_INFO "mydriver: opened device");
    return 0;
}

ssize_t device_read(struct file* filep, char* data, size_t count, loff_t* offset)
{
    printk(KERN_INFO "mydriver: reading from device");
    return raw_copy_to_user(data, virtual_device.data, count);
}

ssize_t device_write(struct file* filep, const char* data, size_t count, loff_t* offset)
{
    printk(KERN_INFO "mydriver: writing to device");
    return raw_copy_to_user(virtual_device.data, data, count);
}

int device_close(struct inode* inode, struct file* filep)
{
    up(&virtual_device.sem);
    printk(KERN_INFO "mydriver: device closed");
    return 0;
}

struct file_operations fops = {
    .owner = THIS_MODULE,
    .open = device_open,
    .release = device_close,
    .write = device_write,
    .read = device_read
};

static int driver_entry(void)
{
    ret = alloc_chrdev_region(&dev_num, 0, 1, DEVICE_NAME);
    if (ret < 0) {
        printk(KERN_ALERT "mydriver: failed to allocate a major number");
        return ret;
    }

    major_number = MAJOR(dev_num);
    printk(KERN_INFO "mydriver: major number is %d", major_number);
    printk(KERN_INFO "mydriver: use \"mknod /dev/%s c %d 0\"", DEVICE_NAME, major_number);

    mycdev = cdev_alloc();
    mycdev->ops = &fops;
    mycdev->owner = THIS_MODULE;

    ret = cdev_add(mycdev, dev_num, 1);
    if (ret < 0) {
        printk(KERN_ALERT "mydriver: unable to add dev to kernel");
        return ret;
    }

    sema_init(&virtual_device.sem, 1);

    return 0;
}

static void driver_exit(void)
{
    cdev_del(mycdev);
    unregister_chrdev_region(dev_num, 1);
    printk(KERN_INFO "mydriver: module unloaded");
}

module_init(driver_entry);
module_exit(driver_exit);
