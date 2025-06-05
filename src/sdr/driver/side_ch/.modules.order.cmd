cmd_/home/flow/openwifi/driver/side_ch/modules.order := {   echo /home/flow/openwifi/driver/side_ch/side_ch.ko; :; } | awk '!x[$$0]++' - > /home/flow/openwifi/driver/side_ch/modules.order
