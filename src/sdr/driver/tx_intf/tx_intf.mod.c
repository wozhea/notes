#include <linux/module.h>
#define INCLUDE_VERMAGIC
#include <linux/build-salt.h>
#include <linux/vermagic.h>
#include <linux/compiler.h>

BUILD_SALT;

MODULE_INFO(vermagic, VERMAGIC_STRING);
MODULE_INFO(name, KBUILD_MODNAME);

__visible struct module __this_module
__section(".gnu.linkonce.this_module") = {
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
__used __section("__versions") = {
	{ 0x67e20a45, "module_layout" },
	{ 0x56b99e1a, "devm_ioremap_resource" },
	{ 0x985eacf1, "__platform_driver_register" },
	{ 0xc5850110, "printk" },
	{ 0xb17d4f2e, "of_match_node" },
	{ 0xaaeccbd3, "platform_get_resource" },
	{ 0x822137e2, "arm_heavy_mb" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
	{ 0xb84ade76, "platform_driver_unregister" },
};

MODULE_INFO(depends, "");

MODULE_ALIAS("of:N*T*Csdr,tx_intf");
MODULE_ALIAS("of:N*T*Csdr,tx_intfC*");
