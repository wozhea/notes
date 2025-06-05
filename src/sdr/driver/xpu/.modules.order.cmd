cmd_/home/flow/openwifi/driver/xpu/modules.order := {   echo /home/flow/openwifi/driver/xpu/xpu.ko; :; } | awk '!x[$$0]++' - > /home/flow/openwifi/driver/xpu/modules.order
