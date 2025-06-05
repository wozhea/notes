cmd_/home/flow/openwifi/driver/rx_intf/modules.order := {   echo /home/flow/openwifi/driver/rx_intf/rx_intf.ko; :; } | awk '!x[$$0]++' - > /home/flow/openwifi/driver/rx_intf/modules.order
