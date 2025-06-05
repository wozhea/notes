## 两个 edge_to_flip module 
没用，只是led显示标志位，没有连接



## dac_intf module 
最后数据转换给ad9361




## tx_iq_intf module
输入发射机数据，经过选择和打包，是否选择随机数据，输出给dac的数据



## tx_intf_s_axis_i module
从连接到pl的dma读数据，dma另一头连接ps通过dma驱动和ps通信，dma和该模块实现pl和ps之间的通信



## tx_bit_intf_i module
最关键的模块，控制交给物理发射机的MAC数据




## tx_status_fifo_i module



## tx_interrupt_selection module