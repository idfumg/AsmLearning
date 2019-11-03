#include <linux/init.h>
#include <linux/module.h>
#include <linux/moduleparam.h>

// insmod hello.ko param=123 params=1,2,3

static int param = 0;
static int params[3] = {0, 0, 0};

module_param(param, int, S_IRUSR | S_IWUSR);
module_param_array(params, int, NULL, S_IRUSR | S_IWUSR);

static void display(void)
{
    printk(__FILE__ ": param = %d", param);
    printk(__FILE__ ": param = %d", params[0]);
    printk(__FILE__ ": param = %d", params[1]);
    printk(__FILE__ ": param = %d", params[2]);
}

static int hello_init(void)
{
    printk(__FILE__ ": Hello, world!\n");
    display();
    return 0;
}

static void hello_exit(void)
{
    printk(__FILE__ ": Goodbye!\n");
}

module_init(hello_init);
module_exit(hello_exit);
