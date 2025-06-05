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
	{ 0xa7b74e99, "param_ops_int" },
	{ 0xb84ade76, "platform_driver_unregister" },
	{ 0x985eacf1, "__platform_driver_register" },
	{ 0x2cfde9a2, "warn_slowpath_fmt" },
	{ 0x46c7e29d, "dev_driver_string" },
	{ 0x6d43c688, "dma_unmap_page_attrs" },
	{ 0xa16b21fb, "wait_for_completion_timeout" },
	{ 0x870d5a1c, "__init_swait_queue_head" },
	{ 0xee4d1bfd, "sg_init_table" },
	{ 0xb492f0a6, "dma_map_page_attrs" },
	{ 0xc1f6b196, "mem_map" },
	{ 0xc31db0ce, "is_vmalloc_addr" },
	{ 0xdcb28d1a, "set_user_nice" },
	{ 0x2e4c28a3, "netlink_unicast" },
	{ 0x9d669763, "memcpy" },
	{ 0x728aab93, "__nlmsg_put" },
	{ 0x25264a10, "__alloc_skb" },
	{ 0x2196324, "__aeabi_idiv" },
	{ 0x86332725, "__stack_chk_fail" },
	{ 0x6c89d972, "kmem_cache_alloc" },
	{ 0x4f85525e, "kmalloc_caches" },
	{ 0xa7ff9396, "dma_request_chan" },
	{ 0x822137e2, "arm_heavy_mb" },
	{ 0x73e8d76b, "__netlink_kernel_create" },
	{ 0x7dad0106, "init_net" },
	{ 0x56b99e1a, "devm_ioremap_resource" },
	{ 0xaaeccbd3, "platform_get_resource" },
	{ 0xb17d4f2e, "of_match_node" },
	{ 0x5f754e5a, "memset" },
	{ 0x8f678b07, "__stack_chk_guard" },
	{ 0xc37335b0, "complete" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
	{ 0x37a0cba, "kfree" },
	{ 0x5814d44e, "dma_release_channel" },
	{ 0xb8eb1255, "netlink_kernel_release" },
	{ 0xc5850110, "printk" },
};

MODULE_INFO(depends, "");

MODULE_ALIAS("of:N*T*Csdr,side_ch");
MODULE_ALIAS("of:N*T*Csdr,side_chC*");
