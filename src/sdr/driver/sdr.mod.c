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
	{ 0x8a06112f, "ieee80211_beacon_get_tim" },
	{ 0xcf86cdac, "queue_delayed_work_on" },
	{ 0xf1969a8e, "__usecs_to_jiffies" },
	{ 0xed3062f5, "ieee80211_queue_stopped" },
	{ 0x50494447, "skb_set_owner_w" },
	{ 0xeb2fd29f, "skb_realloc_headroom" },
	{ 0x34cfc49c, "skb_copy_expand" },
	{ 0x46c7e29d, "dev_driver_string" },
	{ 0xb492f0a6, "dma_map_page_attrs" },
	{ 0xc1f6b196, "mem_map" },
	{ 0xc31db0ce, "is_vmalloc_addr" },
	{ 0x8e865d3c, "arm_delay_ops" },
	{ 0xb65f5101, "ieee80211_stop_queue" },
	{ 0xe3984a67, "skb_push" },
	{ 0x96ca579b, "ieee80211_ctstoself_duration" },
	{ 0xf3d0b495, "_raw_spin_unlock_irqrestore" },
	{ 0xde55e795, "_raw_spin_lock_irqsave" },
	{ 0x530142cb, "kfree_skb" },
	{ 0xa32999f1, "cfg80211_vendor_cmd_reply" },
	{ 0x521237aa, "nla_put" },
	{ 0x54fcb7db, "__cfg80211_alloc_reply_skb" },
	{ 0x420964e3, "__nla_parse" },
	{ 0x76d9b876, "clk_set_rate" },
	{ 0x31ea0d88, "ad9361_do_calib_run" },
	{ 0xe65a0845, "ieee80211_unregister_hw" },
	{ 0xffbc6aca, "sysfs_remove_group" },
	{ 0x9d3e095c, "sysfs_remove_bin_file" },
	{ 0x26581af5, "wiphy_rfkill_stop_polling" },
	{ 0x50e0e211, "ieee80211_free_hw" },
	{ 0x70ab481, "_dev_info" },
	{ 0x5d410220, "sysfs_create_group" },
	{ 0x95d236cc, "sysfs_create_bin_file" },
	{ 0x4957d13, "ieee80211_register_hw" },
	{ 0x79aa04a2, "get_random_bytes" },
	{ 0xee4d1bfd, "sg_init_table" },
	{ 0xcabda604, "wiphy_apply_custom_regulatory" },
	{ 0x39b8a3d8, "cf_axi_dds_datasel" },
	{ 0x27249e75, "platform_bus_type" },
	{ 0x247681d2, "ad9361_spi_to_phy" },
	{ 0xf22b4822, "bus_find_device" },
	{ 0x5f20e17, "spi_bus_type" },
	{ 0x261d891b, "of_property_read_string" },
	{ 0x21064ef5, "of_find_node_opts_by_path" },
	{ 0x3e9a6ac6, "ieee80211_alloc_hw_nm" },
	{ 0xb17d4f2e, "of_match_node" },
	{ 0xff178f6, "__aeabi_idivmod" },
	{ 0x5268bdf, "wiphy_rfkill_start_polling" },
	{ 0x2cfde9a2, "warn_slowpath_fmt" },
	{ 0xdb4912f1, "ieee80211_wake_queue" },
	{ 0x42f1150a, "ieee80211_tx_status_irqsafe" },
	{ 0x3d2b3fb1, "skb_pull" },
	{ 0xfcdc5d14, "_dev_err" },
	{ 0x2072ee9b, "request_threaded_irq" },
	{ 0x5cc623ba, "irq_of_parse_and_map" },
	{ 0x6c89d972, "kmem_cache_alloc" },
	{ 0x4f85525e, "kmalloc_caches" },
	{ 0xefea93ff, "dma_alloc_attrs" },
	{ 0xa7ff9396, "dma_request_chan" },
	{ 0x65d52370, "openofdm_rx_api" },
	{ 0x3f7c4c62, "openofdm_tx_api" },
	{ 0x241a9d7a, "ad9361_ctrl_outs_setup" },
	{ 0xdae33064, "ad9361_set_tx_atten" },
	{ 0x2d6611f1, "ieee80211_rx_irqsafe" },
	{ 0x9d669763, "memcpy" },
	{ 0x7ae293e6, "skb_put" },
	{ 0xfb218693, "__netdev_alloc_skb" },
	{ 0xa0439cbc, "_raw_spin_unlock" },
	{ 0xae577d60, "_raw_spin_lock" },
	{ 0xc1514a3b, "free_irq" },
	{ 0x5814d44e, "dma_release_channel" },
	{ 0x60bfc087, "ad9361_tx_mute" },
	{ 0x37a0cba, "kfree" },
	{ 0x6d43c688, "dma_unmap_page_attrs" },
	{ 0x6c91af01, "dma_free_attrs" },
	{ 0xc6f46339, "init_timer_key" },
	{ 0xffeedf6a, "delayed_work_timer_fn" },
	{ 0xb2d48a2e, "queue_work_on" },
	{ 0x2d3385d3, "system_wq" },
	{ 0x29d9f26e, "cancel_delayed_work_sync" },
	{ 0x443ac7f8, "ieee80211_start_tx_ba_cb_irqsafe" },
	{ 0x3613f13c, "ieee80211_stop_tx_ba_cb_irqsafe" },
	{ 0x222e7ce2, "sysfs_streq" },
	{ 0xd0ed9c00, "ad9361_spi_read" },
	{ 0xd60f4b9b, "rx_intf_api" },
	{ 0x1e6d26a8, "strstr" },
	{ 0x69ad2f20, "kstrtouint" },
	{ 0x3c3ff9fd, "sprintf" },
	{ 0x88dc2568, "tx_intf_api" },
	{ 0x5f754e5a, "memset" },
	{ 0x86332725, "__stack_chk_fail" },
	{ 0x4ea56f9, "_kstrtol" },
	{ 0x8f678b07, "__stack_chk_guard" },
	{ 0x96b5ad5, "wiphy_rfkill_set_hw_state" },
	{ 0x8802d372, "ad9361_get_tx_atten" },
	{ 0xc5850110, "printk" },
	{ 0x2c205cf0, "xpu_api" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
};

MODULE_INFO(depends, "mac80211,cfg80211,ad9361_drv,openofdm_rx,openofdm_tx,rx_intf,tx_intf,xpu");

MODULE_ALIAS("of:N*T*Csdr,sdr");
MODULE_ALIAS("of:N*T*Csdr,sdrC*");
