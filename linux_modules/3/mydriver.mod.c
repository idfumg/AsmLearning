#include <linux/build-salt.h>
#include <linux/module.h>
#include <linux/vermagic.h>
#include <linux/compiler.h>

BUILD_SALT;

MODULE_INFO(vermagic, VERMAGIC_STRING);
MODULE_INFO(name, KBUILD_MODNAME);

__visible struct module __this_module
__attribute__((section(".gnu.linkonce.this_module"))) = {
	.name = KBUILD_MODNAME,
	.init = init_module,
#ifdef CONFIG_MODULE_UNLOAD
	.exit = cleanup_module,
#endif
	.arch = MODULE_ARCH_INIT,
};

#ifdef CONFIG_RETPOLINE
MODULE_INFO(retpoline, "Y");
#endif

static const struct modversion_info ____versions[]
__used
__attribute__((section("__versions"))) = {
	{ 0x73e4864d, "module_layout" },
	{ 0x6091b333, "unregister_chrdev_region" },
	{ 0xea21a3f8, "cdev_del" },
	{ 0xe6795d6a, "cdev_add" },
	{ 0x8af80665, "cdev_alloc" },
	{ 0xe3ec2f2b, "alloc_chrdev_region" },
	{ 0xcf2a6966, "up" },
	{ 0x26948d96, "copy_user_enhanced_fast_string" },
	{ 0xafb8c6ff, "copy_user_generic_string" },
	{ 0x72a98fdb, "copy_user_generic_unrolled" },
	{ 0x7c32d0f0, "printk" },
	{ 0x81b395b3, "down_interruptible" },
	{ 0xbdfb6dbb, "__fentry__" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=";


MODULE_INFO(srcversion, "34D76D23979A10CCF0268F5");
