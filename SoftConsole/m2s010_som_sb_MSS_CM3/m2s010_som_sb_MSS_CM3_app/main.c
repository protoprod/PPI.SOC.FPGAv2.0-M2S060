#include "drivers/mss_gpio/mss_gpio.h"
#include "CMSIS/system_m2sxxx.h"
#include "drivers_config/sys_config/sys_config.h"
#include "mss_uart.h"
#include "m2s010_som_hw_platform.h"
#include <stdlib.h>

// Check to ensure that below is set correctly.  Will reset to "0" when firmware is re-exported.
#if (MSS_SYS_MDDR_CONFIG_BY_CORTEX == 1)
#error "Please turn off DDR initialization! See the comment in this file above."
#endif
#define RAM_BASE_ADDR	0xA0000000

uint32_t MDDR_status=0;

void config_mddr_lpddr(void)
{
    MDDR->core.ddrc.DYN_SOFT_RESET_CR 		        = 0x0000;
    MDDR->core.ddrc.DYN_REFRESH_1_CR 				= 0x27de;
    MDDR->core.ddrc.DYN_REFRESH_2_CR 		        = 0x030f;
    MDDR->core.ddrc.DYN_POWERDOWN_CR 		        = 0x0002;
    MDDR->core.ddrc.DYN_DEBUG_CR 		        	= 0x0000;
    MDDR->core.ddrc.MODE_CR 			        	= 0x00C1;
    MDDR->core.ddrc.ADDR_MAP_BANK_CR 		        = 0x099f;
    MDDR->core.ddrc.ECC_DATA_MASK_CR 		        = 0x0000;
    MDDR->core.ddrc.ADDR_MAP_COL_1_CR 		        = 0x3333;
    MDDR->core.ddrc.ADDR_MAP_COL_2_CR 		        = 0xffff;
    MDDR->core.ddrc.ADDR_MAP_ROW_1_CR 		        = 0x7777;
    MDDR->core.ddrc.ADDR_MAP_ROW_2_CR 		        = 0x0fff;
    MDDR->core.ddrc.INIT_1_CR 			        	= 0x0001;
    MDDR->core.ddrc.CKE_RSTN_CYCLES_CR[0] 	       	= 0x4242;
    MDDR->core.ddrc.CKE_RSTN_CYCLES_CR[1] 	       	= 0x0008;
    MDDR->core.ddrc.INIT_MR_CR 			        	= 0x0033;
    MDDR->core.ddrc.INIT_EMR_CR 		        	= 0x0020;
    MDDR->core.ddrc.INIT_EMR2_CR 		        	= 0x0000;
    MDDR->core.ddrc.INIT_EMR3_CR 		        	= 0x0000;
    MDDR->core.ddrc.DRAM_BANK_TIMING_PARAM_CR		= 0x00c0;
    MDDR->core.ddrc.DRAM_RD_WR_LATENCY_CR 	       	= 0x0023;
    MDDR->core.ddrc.DRAM_RD_WR_PRE_CR 		        = 0x0235;
    MDDR->core.ddrc.DRAM_MR_TIMING_PARAM_CR			= 0x0064;
    MDDR->core.ddrc.DRAM_RAS_TIMING_CR 		        = 0x0108;
    MDDR->core.ddrc.DRAM_RD_WR_TRNARND_TIME_CR		= 0x0178;
    MDDR->core.ddrc.DRAM_T_PD_CR 		        	= 0x0033;
    MDDR->core.ddrc.DRAM_BANK_ACT_TIMING_CR			= 0x1947;
    MDDR->core.ddrc.ODT_PARAM_1_CR					= 0x0010;
    MDDR->core.ddrc.ODT_PARAM_2_CR					= 0x0000;
    MDDR->core.ddrc.ADDR_MAP_COL_3_CR 		        = 0x3300;
    MDDR->core.ddrc.MODE_REG_RD_WR_CR 		        = 0x0000;
    MDDR->core.ddrc.MODE_REG_DATA_CR 		        = 0x0000;
    MDDR->core.ddrc.PWR_SAVE_1_CR 		       		= 0x0514;
    MDDR->core.ddrc.PWR_SAVE_2_CR 		       		= 0x0000;
    MDDR->core.ddrc.ZQ_LONG_TIME_CR 		        = 0x0200;
    MDDR->core.ddrc.ZQ_SHORT_TIME_CR 		        = 0x0040;
    MDDR->core.ddrc.ZQ_SHORT_INT_REFRESH_MARGIN_CR[0] 	= 0x0012;
    MDDR->core.ddrc.ZQ_SHORT_INT_REFRESH_MARGIN_CR[1] 	= 0x0002;
    MDDR->core.ddrc.PERF_PARAM_1_CR 			= 0x4000;
    MDDR->core.ddrc.HPR_QUEUE_PARAM_CR[0]	 	= 0x80f8;
    MDDR->core.ddrc.HPR_QUEUE_PARAM_CR[1] 	 	= 0x0007;
    MDDR->core.ddrc.LPR_QUEUE_PARAM_CR[0] 	 	= 0x80f8;
    MDDR->core.ddrc.LPR_QUEUE_PARAM_CR[1] 	 	= 0x0007;
    MDDR->core.ddrc.WR_QUEUE_PARAM_CR 	 		= 0x0200;
    MDDR->core.ddrc.PERF_PARAM_2_CR 	 		= 0x0001;
    MDDR->core.ddrc.PERF_PARAM_3_CR 	 		= 0x0000;
    MDDR->core.ddrc.DFI_RDDATA_EN_CR 	 		= 0x0003;
    MDDR->core.ddrc.DFI_MIN_CTRLUPD_TIMING_CR 	= 0x0003;
    MDDR->core.ddrc.DFI_MAX_CTRLUPD_TIMING_CR 	= 0x0040;
    MDDR->core.ddrc.DFI_WR_LVL_CONTROL_CR[0] 	= 0x0000;
    MDDR->core.ddrc.DFI_WR_LVL_CONTROL_CR[1] 	= 0x0000;
    MDDR->core.ddrc.DFI_RD_LVL_CONTROL_CR[0] 	= 0x0000;
    MDDR->core.ddrc.DFI_RD_LVL_CONTROL_CR[1] 	= 0x0000;
    MDDR->core.ddrc.DFI_CTRLUPD_TIME_INTERVAL_CR	= 0x0309;
    MDDR->core.ddrc.AXI_FABRIC_PRI_ID_CR 		= 0x0000;
    MDDR->core.ddrc.ECC_INT_CLR_REG 			= 0x0000;

    MDDR->core.phy.LOOPBACK_TEST_CR 			= 0x0000;
    MDDR->core.phy.CTRL_SLAVE_RATIO_CR 			= 0x0080;
    MDDR->core.phy.DATA_SLICE_IN_USE_CR 		= 0x0003;
    MDDR->core.phy.DQ_OFFSET_CR[0] 				= 0x00000000;
    MDDR->core.phy.DQ_OFFSET_CR[2] 				= 0x0000;
    MDDR->core.phy.DLL_LOCK_DIFF_CR  			= 0x000B;
    MDDR->core.phy.FIFO_WE_SLAVE_RATIO_CR[0] 	= 0x0040;
    MDDR->core.phy.FIFO_WE_SLAVE_RATIO_CR[1] 	= 0x0401;
    MDDR->core.phy.FIFO_WE_SLAVE_RATIO_CR[2] 	= 0x4010;
    MDDR->core.phy.FIFO_WE_SLAVE_RATIO_CR[3] 	= 0x0000;
    MDDR->core.phy.LOCAL_ODT_CR  				= 0x0001;
    MDDR->core.phy.RD_DQS_SLAVE_RATIO_CR[0]  	= 0x0040;
    MDDR->core.phy.RD_DQS_SLAVE_RATIO_CR[1]  	= 0x0401;
    MDDR->core.phy.RD_DQS_SLAVE_RATIO_CR[2]  	= 0x4010;
    MDDR->core.phy.WR_DATA_SLAVE_RATIO_CR[0]  	= 0x0040;
    MDDR->core.phy.WR_DATA_SLAVE_RATIO_CR[1]  	= 0x0401;
    MDDR->core.phy.WR_DATA_SLAVE_RATIO_CR[2]  	= 0x4010;
    MDDR->core.phy.WR_RD_RL_CR  				= 0x0021;
    MDDR->core.phy.RDC_WE_TO_RE_DELAY_CR  		= 0x0003;
    MDDR->core.phy.USE_FIXED_RE_CR  			= 0x0001;
    MDDR->core.phy.USE_RANK0_DELAYS_CR  		= 0x0001;
    MDDR->core.phy.CONFIG_CR  			 		= 0x0009;
    MDDR->core.phy.DYN_RESET_CR  				= 0x01;
    MDDR->core.ddrc.DYN_SOFT_RESET_CR  			= 0x01;

    while((MDDR->core.ddrc.DDRC_SR) == 0x0000)
    {
        ;
    }
}

/*******************************************************************************
 * Defines
 */
#define Menu \
"\n\r\n\r \
Press number for Action \n\r\n\r \
1  Read FPGA Registers \n\r \
2  Reset Receive FIFO \n\r \
3  Reset Transmit FIFO \n\r \
4  Transmit Single Packet - INTERNAL Loopback \n\r \
5  Receive Single Packet and Check - INTERNAL Loopback \n\r \
6  Loopback Packets from 8 to 1023 Bytes & Check - INTERNAL Loopback \n\r \
7  Transmit Single Packet - EXTERNAL Loopback \n\r \
8  Receive Single Packet and Check - EXTERNAL Loopback \n\r \
9  Transmit Packets from 8 to 1023 Bytes & Check - EXTERNAL Loopback \n\r \
a  Transmit Board 2 Board Single Packet \n\r \
b  Receive Board 2 Board Single Packet and Check \n\r \
c  Transmit Board 2 Board Multiple Packets \n\r \
d  Receive Board 2 Board Multiple Packets \n\r \
e  Transmit Packet Blaster. \n\r \
f  Reset FPGA Logic. \n\r \
g  Blaster Packet Loopback Address = 0x2AA \n\r \
h  Blaster Packet Loopback Address = 0x2AB \n\r \
i  Blaster Packet Loopback Address = 0x3CC \n\r"

//#define COMMSFPGA_TOP_0                 0x50000000U

/*******************************************************************************
 * Prototypes
 */
void main();
void print_registers();
void SW_reset();
void tx_fifo_reset();
void rx_fifo_reset();

void fill_tx_message
(
  uint32_t address,
  uint32_t length,
  uint32_t LoopType,
  uint32_t TxBlaster
  
);

int check_rx_message
(
  uint32_t address,
  uint32_t length,
  uint32_t supress
);

void packet_loopback
(
  uint32_t address,
  uint32_t length,
  uint32_t iterations,
  uint32_t LoopType,
  uint32_t TxBlaster
);

void blaster_packet_loopback
(
  uint32_t address,
  uint32_t length,
  uint32_t iterations,
  uint32_t LoopType,
  uint32_t TxBlaster
);

void TX_blaster_packet
(
  uint32_t address,
  uint32_t length,
  uint32_t iterations,
  uint32_t LoopType,
  uint32_t TxBlaster
);

void RX_blaster_packet
(
  uint32_t address,
  uint32_t length,
  uint32_t iterations
);

void b2b_single_tx_message_send
(
  uint32_t address,
  uint32_t length,
  uint32_t TxBlaster
);

int b2b_single_rx_message_check
(
  uint32_t address,
  uint32_t length
);

void b2b_multiple_tx_message_send
(
  uint32_t address,
  uint32_t length,
  uint32_t iterations,
  uint32_t TxBlaster
);

void b2b_multiple_tx_message_blast
(
  uint32_t address,
  uint32_t length,
  uint32_t iterations,
  uint32_t TxBlaster
);

void b2b_multiple_rx_message_check
(
  uint32_t address,
  uint32_t length,
  uint32_t iterations
);

void tohexstring(char [], int);

/* Main function */
void main()
{

  volatile uint32_t *p_FPGA_interrupt_reg;
  uint32_t *p_FPGA_control_reg;
  uint32_t *p_FPGA_high_addr_reg;
  uint32_t *p_FPGA_low_addr_reg; 
    
  uint8_t  uart0_rx_buff[1024];
  uint8_t  num_press;
  uint32_t uart0_rx_size;
  uint32_t packet_length;
  uint32_t consumer_address;
  uint32_t packet_iterations;
  uint32_t packet_iterations_init;
  uint32_t temp;
  uint32_t LoopType;
  uint32_t TxBlaster;
  uint32_t gpio_outputs;
  
  char *memptr = (char *)RAM_BASE_ADDR;

  const uint8_t greeting[]        = "\n\r Enter:  ";

  p_FPGA_interrupt_reg       = (uint32_t)COMMSFPGA_TOP_0 + 0x14;
  p_FPGA_control_reg         = (uint32_t)COMMSFPGA_TOP_0 + 0x10;
  p_FPGA_high_addr_reg       = (uint32_t)COMMSFPGA_TOP_0 + 0x30;
  p_FPGA_low_addr_reg        = (uint32_t)COMMSFPGA_TOP_0 + 0x34;
    
  /*
   * Initialize MSS GPIOs.
   */
  MSS_GPIO_init();

    /*
     * Configure MSS GPIOs.
     */
    MSS_GPIO_config( MSS_GPIO_0 , MSS_GPIO_INOUT_MODE  );
    MSS_GPIO_config( MSS_GPIO_1 , MSS_GPIO_OUTPUT_MODE );
    MSS_GPIO_config( MSS_GPIO_2 , MSS_GPIO_INPUT_MODE  );
    MSS_GPIO_config( MSS_GPIO_3 , MSS_GPIO_INOUT_MODE  );
    MSS_GPIO_config( MSS_GPIO_4 , MSS_GPIO_INOUT_MODE  );
    MSS_GPIO_config( MSS_GPIO_5 , MSS_GPIO_OUTPUT_MODE );
    MSS_GPIO_config( MSS_GPIO_6 , MSS_GPIO_OUTPUT_MODE );
    MSS_GPIO_config( MSS_GPIO_7 , MSS_GPIO_OUTPUT_MODE );
    MSS_GPIO_config( MSS_GPIO_8 , MSS_GPIO_OUTPUT_MODE );
    MSS_GPIO_config( MSS_GPIO_9 , MSS_GPIO_INPUT_MODE  );
    MSS_GPIO_config( MSS_GPIO_10, MSS_GPIO_INPUT_MODE  );
    MSS_GPIO_config( MSS_GPIO_11, MSS_GPIO_OUTPUT_MODE );
    MSS_GPIO_config( MSS_GPIO_12, MSS_GPIO_INOUT_MODE  );
    MSS_GPIO_config( MSS_GPIO_13, MSS_GPIO_OUTPUT_MODE );
    MSS_GPIO_config( MSS_GPIO_14, MSS_GPIO_INOUT_MODE  );
    MSS_GPIO_config( MSS_GPIO_15, MSS_GPIO_INOUT_MODE  );
    MSS_GPIO_config( MSS_GPIO_16, MSS_GPIO_INOUT_MODE  );
    MSS_GPIO_config( MSS_GPIO_17, MSS_GPIO_INOUT_MODE  );
    MSS_GPIO_config( MSS_GPIO_18, MSS_GPIO_INOUT_MODE  );
    MSS_GPIO_config( MSS_GPIO_19, MSS_GPIO_INPUT_MODE  );
    MSS_GPIO_config( MSS_GPIO_20, MSS_GPIO_OUTPUT_MODE );
    MSS_GPIO_config( MSS_GPIO_21, MSS_GPIO_OUTPUT_MODE );
    MSS_GPIO_config( MSS_GPIO_22, MSS_GPIO_OUTPUT_MODE );

    MSS_GPIO_config( MSS_GPIO_24, MSS_GPIO_OUTPUT_MODE );
    MSS_GPIO_config( MSS_GPIO_25, MSS_GPIO_INOUT_MODE  );
    MSS_GPIO_config( MSS_GPIO_26, MSS_GPIO_INOUT_MODE  );

    MSS_GPIO_config( MSS_GPIO_28 , MSS_GPIO_OUTPUT_MODE );

    MSS_GPIO_config( MSS_GPIO_31, MSS_GPIO_INOUT_MODE  );

    /*
     * Initialize and configure uart0.
     */  
    MSS_UART_init
    (
      &g_mss_uart0,
      MSS_UART_57600_BAUD,
      MSS_UART_DATA_8_BITS | MSS_UART_NO_PARITY | MSS_UART_ONE_STOP_BIT
    );

  /* Send the Microsemi Logo over the UART_1 */
  MSS_UART_polled_tx_string( &g_mss_uart0, (const uint8_t *)Menu);

  /* Send greeting message over the UART_1 */
  MSS_UART_polled_tx( &g_mss_uart0, greeting, sizeof(greeting) );


  /* Take FPGA out of Reset */
  gpio_outputs = MSS_GPIO_get_outputs();
  gpio_outputs &= ~( MSS_GPIO_28_MASK );
  MSS_GPIO_set_outputs( gpio_outputs );


  /*                           */
  /* Initialize the DDR Memory */
  /*                           */
    config_mddr_lpddr();

  /* Reset FIFOs    */
  tx_fifo_reset();
  rx_fifo_reset();

  /* Clear an Interrupts */
  temp = *p_FPGA_interrupt_reg;

  /* Initialize FPGA Address Register (aka Consumer Register */
  *p_FPGA_high_addr_reg = 0x00000002;
  *p_FPGA_low_addr_reg  = 0x000000A9;

  /* Disable Loopback */
  *p_FPGA_control_reg = 0x00000000;
  
//  packet_length    = 0x200;   // 512 bytes
  TxBlaster              = 1;
  packet_length          = 0x08;
  packet_iterations_init = 0x001;  //0x7D0;  //0x406;
  packet_iterations = packet_iterations_init;  //0x406;
  consumer_address = 0x000002A9;

  while(1)
  {
      uart0_rx_size = MSS_UART_get_rx( &g_mss_uart0, uart0_rx_buff, sizeof(uart0_rx_buff) );
      num_press = *uart0_rx_buff;

      if (uart0_rx_size > 0)
        {
          MSS_UART_polled_tx( &g_mss_uart0, uart0_rx_buff, uart0_rx_size );

            switch ( num_press ) {
              case '1':
                print_registers();
               	MSS_UART_polled_tx_string( &g_mss_uart0, "\n\r\n\r" );
                MSS_UART_polled_tx_string( &g_mss_uart0, (const uint8_t *)Menu);
                MSS_UART_polled_tx( &g_mss_uart0, greeting, sizeof(greeting) );
            	  break;
              case '2':
               	MSS_UART_polled_tx_string( &g_mss_uart0, "\n\r\n\r Reset Receive FIFO... \n\r" );
              	rx_fifo_reset();
                MSS_UART_polled_tx_string( &g_mss_uart0, (const uint8_t *)Menu);
                MSS_UART_polled_tx( &g_mss_uart0, greeting, sizeof(greeting) );
                break;
              case '3':
               	MSS_UART_polled_tx_string( &g_mss_uart0, "\n\r\n\r Reset Transmit FIFO... \n\r" );
              	tx_fifo_reset();
                MSS_UART_polled_tx_string( &g_mss_uart0, (const uint8_t *)Menu);
                MSS_UART_polled_tx( &g_mss_uart0, greeting, sizeof(greeting) );
                break;
              case '4':
                MSS_UART_polled_tx_string( &g_mss_uart0, "\n\r\n\r Transmitting Single Packet - Internal Loopback... \n\r" );
                LoopType = 0x00000001;
                TxBlaster = 0;
                fill_tx_message ( consumer_address, packet_length, LoopType, TxBlaster  );
                MSS_UART_polled_tx_string( &g_mss_uart0, (const uint8_t *)Menu);
                MSS_UART_polled_tx( &g_mss_uart0, greeting, sizeof(greeting) );
                break;
              case '5':
              	MSS_UART_polled_tx_string( &g_mss_uart0, "\n\r\n\r Receive Signle Packet and Check - Internal Loopback... \n\r" );
              	check_rx_message ( consumer_address, packet_length, 0 );
                MSS_UART_polled_tx_string( &g_mss_uart0, (const uint8_t *)Menu);
                MSS_UART_polled_tx( &g_mss_uart0, greeting, sizeof(greeting) );
                break;
              case '6':
                MSS_UART_polled_tx_string( &g_mss_uart0, "\n\r\n\r Looping Back Packets Ranging in Size from 8 Bytes to 2008 Bytes - Internal Loopback...  \n\r" );
                LoopType = 0x00000001;
                TxBlaster = 1;
                packet_iterations = packet_iterations_init;  //0x406;
                packet_loopback ( consumer_address, packet_length, packet_iterations, LoopType, TxBlaster  );
                MSS_UART_polled_tx_string( &g_mss_uart0, (const uint8_t *)Menu);
                MSS_UART_polled_tx( &g_mss_uart0, greeting, sizeof(greeting) );
                break;
              case '7':
                MSS_UART_polled_tx_string( &g_mss_uart0, "\n\r\n\r Transmitting Single Packet - EXTERNAL Loopback... \n\r" );
                LoopType = 0x00000002;
                TxBlaster = 1;
                fill_tx_message ( consumer_address, packet_length, LoopType, TxBlaster  );
                MSS_UART_polled_tx_string( &g_mss_uart0, (const uint8_t *)Menu);
                MSS_UART_polled_tx( &g_mss_uart0, greeting, sizeof(greeting) );
                break;
              case '8':
              	MSS_UART_polled_tx_string( &g_mss_uart0, "\n\r\n\r Receive Single Packet and Check - EXTERNAL Loopback... \n\r" );
              	check_rx_message ( consumer_address, packet_length, 0 );
                MSS_UART_polled_tx_string( &g_mss_uart0, (const uint8_t *)Menu);
                MSS_UART_polled_tx( &g_mss_uart0, greeting, sizeof(greeting) );
                break;
              case '9':
                MSS_UART_polled_tx_string( &g_mss_uart0, "\n\r\n\r Looping Back Packets Range 8 to 2008 Bytes - EXTERNAL Loopback...  \n\r" );
                LoopType = 0x00000002;
                TxBlaster = 1;
                packet_iterations = packet_iterations_init;  //0x406;
                packet_loopback ( consumer_address, packet_length, packet_iterations, LoopType, TxBlaster  );
                MSS_UART_polled_tx_string( &g_mss_uart0, (const uint8_t *)Menu);
                MSS_UART_polled_tx( &g_mss_uart0, greeting, sizeof(greeting) );
                break; 
              case 'a':
                MSS_UART_polled_tx_string( &g_mss_uart0, "\n\r\n\r Transmiting Board to Board Single Packet... \n\r" );
                packet_length    = 0x3F9;  //0x08 0x3F9;;
                consumer_address = 0x000002A8; 
                TxBlaster        = 1;
                b2b_single_tx_message_send ( consumer_address, packet_length, TxBlaster );
                MSS_UART_polled_tx_string( &g_mss_uart0, (const uint8_t *)Menu);
                MSS_UART_polled_tx( &g_mss_uart0, greeting, sizeof(greeting) );
                consumer_address = 0x000002A9;
                break;
              case 'b':
              	MSS_UART_polled_tx_string( &g_mss_uart0, "\n\r\n\r Receiving Board to Board Single Packet and Check... \n\r" );
              	packet_length    = 0x3F9;  //0x08;
                consumer_address = 0x000002A8;
              	b2b_single_rx_message_check ( consumer_address, packet_length );
                MSS_UART_polled_tx_string( &g_mss_uart0, (const uint8_t *)Menu);
                MSS_UART_polled_tx( &g_mss_uart0, greeting, sizeof(greeting) );
                consumer_address = 0x000002A9;
                break;
              case 'c':
                MSS_UART_polled_tx_string( &g_mss_uart0, "\n\r\n\r Transmitting Board to Board Multiple Packets... \n\r" );
                packet_length    = 0x08;
                consumer_address = 0x000002A8;
                TxBlaster        = 1;
                packet_iterations = packet_iterations_init;  //0x406;
                b2b_multiple_tx_message_send ( consumer_address, packet_length, packet_iterations, TxBlaster );
                MSS_UART_polled_tx_string( &g_mss_uart0, (const uint8_t *)Menu);
                MSS_UART_polled_tx( &g_mss_uart0, greeting, sizeof(greeting) );
                consumer_address = 0x000002A9;
                break;
              case 'd':
                MSS_UART_polled_tx_string( &g_mss_uart0, "\n\r\n\r Receiving Board to Board Multiple Packets... \n\r" );
                packet_length    = 0x08;
                consumer_address = 0x000002A8;
                packet_iterations = packet_iterations_init;  //0x406;
                b2b_multiple_rx_message_check ( consumer_address, packet_length, packet_iterations );
                MSS_UART_polled_tx_string( &g_mss_uart0, (const uint8_t *)Menu);
                MSS_UART_polled_tx( &g_mss_uart0, greeting, sizeof(greeting) );
                consumer_address = 0x000002A9;
                break;
              case 'e':
                MSS_UART_polled_tx_string( &g_mss_uart0, "\n\r\n\r Transmit Packet Blaster. \n\r" );
                consumer_address = 0x00000200;
                packet_length    = 0x03E8;
                packet_iterations = 0x10000;
                TxBlaster        = 1;
                b2b_multiple_tx_message_blast ( consumer_address, packet_length, packet_iterations, TxBlaster );
                MSS_UART_polled_tx_string( &g_mss_uart0, (const uint8_t *)Menu);
                MSS_UART_polled_tx( &g_mss_uart0, greeting, sizeof(greeting) );
                consumer_address = 0x000002A9;
                packet_length    = 0x08;
                packet_iterations = packet_iterations_init;
                TxBlaster         = 1;
                break;  
              case 'f':
                MSS_UART_polled_tx_string( &g_mss_uart0, "\n\r\n\r Reset FPGA Logic. \n\r" );
                SW_reset();
                MSS_UART_polled_tx_string( &g_mss_uart0, (const uint8_t *)Menu);
                MSS_UART_polled_tx( &g_mss_uart0, greeting, sizeof(greeting) );
                break; 
              case 'g':
                MSS_UART_polled_tx_string( &g_mss_uart0, "\n\r\n\r Blaster Packet Loopback Address = 0x2AA \n\r" );
                LoopType          = 0x00000002;
                TxBlaster         = 1;
                consumer_address  = 0x000002AA;
                packet_iterations = packet_iterations_init;  //0x406;
                blaster_packet_loopback ( consumer_address, packet_length, 
                                          packet_iterations, LoopType, TxBlaster );
                MSS_UART_polled_tx_string( &g_mss_uart0, (const uint8_t *)Menu);
                MSS_UART_polled_tx( &g_mss_uart0, greeting, sizeof(greeting) );
                break; 
              case 'h':
                MSS_UART_polled_tx_string( &g_mss_uart0, "\n\r\n\r Blaster Packet Loopback Address = 0x2AB \n\r" );
                LoopType          = 0x00000002;
                TxBlaster         = 1;
                consumer_address  = 0x000002AB;
                packet_iterations = packet_iterations_init;  //0x406;
                blaster_packet_loopback ( consumer_address, packet_length, 
                                          packet_iterations, LoopType, TxBlaster );
                MSS_UART_polled_tx_string( &g_mss_uart0, (const uint8_t *)Menu);
                MSS_UART_polled_tx( &g_mss_uart0, greeting, sizeof(greeting) );
                break;                 
              case 'i':
                MSS_UART_polled_tx_string( &g_mss_uart0, "\n\r\n\r Blaster Packet Loopback Address = 0x3CC \n\r" );
                LoopType          = 0x00000002;
                TxBlaster         = 1;
                consumer_address  = 0x000003CC;
                packet_iterations = packet_iterations_init;  //0x406;
                blaster_packet_loopback ( consumer_address, packet_length, 
                                          packet_iterations, LoopType, TxBlaster );
                MSS_UART_polled_tx_string( &g_mss_uart0, (const uint8_t *)Menu);
                MSS_UART_polled_tx( &g_mss_uart0, greeting, sizeof(greeting) );
                break;
              default:
              	MSS_UART_polled_tx_string( &g_mss_uart0, "\n\r\n\r Press any number... \n\r\n\r" );
            	  MSS_UART_polled_tx_string( &g_mss_uart0, (const uint8_t *)Menu);
                MSS_UART_polled_tx( &g_mss_uart0, greeting, sizeof(greeting) );
            	break;
          }
        }    
  }
  return;

}

/*****************************************************************************
*  NAME:        print_registers()
*
*  DESCRIPTION: This prototype prints the FPGA registers and displays then on
*               the console. (When I get the int to character function working.)
*
*  INPUTS:      address = defines the destination address or consumer.
*               length  = defines the length of the packet.  Must be between
*                         8 bytes and 1024 bytes.
*
******************************************************************************/
/*****************************************************************************
* This prototpye prints the FPGA registers and displays then on the console.
* (When I get the int to character function working)
******************************************************************************/
void print_registers()
{

  uint32_t *p_FPGA_revision_reg;
  uint32_t *p_FPGA_scratch_reg;
  uint32_t *p_FPGA_control_reg;
  volatile uint32_t *p_FPGA_interrupt_reg;
  uint32_t *p_FPGA_interrupt_mask_reg;
  volatile uint32_t *p_FPGA_status_reg;
  uint32_t *p_FPGA_BL_USB_control_reg;
  uint32_t *p_FPGA_BL_USB_status_reg;
  uint32_t *p_FPGA_address_high_reg;
  uint32_t *p_FPGA_address_low_reg;

  uint32_t reg_int;

  uint8_t FPGA_revision_reg;
  uint8_t FPGA_scratch_reg;
  uint8_t FPGA_control_reg;
  uint8_t FPGA_interrupt_reg;
  uint8_t FPGA_interrupt_mask_reg;
  uint8_t FPGA_status_reg;
  uint8_t FPGA_address_high_reg;
  uint8_t FPGA_address_low_reg;

  char    UART_in_string [8];

  p_FPGA_revision_reg        = (uint32_t)COMMSFPGA_TOP_0;
  p_FPGA_scratch_reg         = (uint32_t)COMMSFPGA_TOP_0 + 0x4;
  p_FPGA_control_reg         = (uint32_t)COMMSFPGA_TOP_0 + 0x10;
  p_FPGA_interrupt_reg       = (uint32_t)COMMSFPGA_TOP_0 + 0x14;
  p_FPGA_interrupt_mask_reg  = (uint32_t)COMMSFPGA_TOP_0 + 0x18;
  p_FPGA_status_reg          = (uint32_t)COMMSFPGA_TOP_0 + 0x1C;
  p_FPGA_address_high_reg    = (uint32_t)COMMSFPGA_TOP_0 + 0x30;
  p_FPGA_address_low_reg     = (uint32_t)COMMSFPGA_TOP_0 + 0x34;

  MSS_UART_polled_tx_string( &g_mss_uart0, "\n\r\n\r  FPGA Revision Register:       0x" );
  reg_int = *p_FPGA_revision_reg;
  tohexstring(UART_in_string, reg_int);
  MSS_UART_polled_tx( &g_mss_uart0, UART_in_string, sizeof(UART_in_string) );
  //MSS_UART_polled_tx( &g_mss_uart0, p_FPGA_revision_reg, sizeof(p_FPGA_revision_reg) );

  MSS_UART_polled_tx_string( &g_mss_uart0,     "\n\r  FPGA Scratch Pad Register:    0x" );
  reg_int = *p_FPGA_scratch_reg;
  tohexstring(UART_in_string, reg_int);
  MSS_UART_polled_tx( &g_mss_uart0, UART_in_string, sizeof(UART_in_string) );

  MSS_UART_polled_tx_string( &g_mss_uart0,     "\n\r  FPGA Control Register:        0x" );
  reg_int = *p_FPGA_control_reg;
  tohexstring(UART_in_string, reg_int);
  MSS_UART_polled_tx( &g_mss_uart0, UART_in_string, sizeof(UART_in_string) );

  MSS_UART_polled_tx_string( &g_mss_uart0,     "\n\r  FPGA Interrupt Register:      0x" );
  reg_int = *p_FPGA_interrupt_reg;
  tohexstring(UART_in_string, reg_int);
  MSS_UART_polled_tx( &g_mss_uart0, UART_in_string, sizeof(UART_in_string) );

  MSS_UART_polled_tx_string( &g_mss_uart0,     "\n\r  FPGA Interrupt Mask Register: 0x" );
  reg_int = *p_FPGA_interrupt_mask_reg;
  tohexstring(UART_in_string, reg_int);
  MSS_UART_polled_tx( &g_mss_uart0, UART_in_string, sizeof(UART_in_string) );

  MSS_UART_polled_tx_string( &g_mss_uart0,     "\n\r  FPGA Status Register:         0x" );
  reg_int = *p_FPGA_status_reg;
  tohexstring(UART_in_string, reg_int);
  MSS_UART_polled_tx( &g_mss_uart0, UART_in_string, sizeof(UART_in_string) );

  MSS_UART_polled_tx_string( &g_mss_uart0,     "\n\r  FPGA High Address Register:   0x" );
  reg_int = *p_FPGA_address_high_reg;
  tohexstring(UART_in_string, reg_int);
  MSS_UART_polled_tx( &g_mss_uart0, UART_in_string, sizeof(UART_in_string) );

  MSS_UART_polled_tx_string( &g_mss_uart0,     "\n\r  FPGA Low Address Register:    0x" );
  reg_int = *p_FPGA_address_low_reg;
  tohexstring(UART_in_string, reg_int);
  MSS_UART_polled_tx( &g_mss_uart0, UART_in_string, sizeof(UART_in_string) );

return;

}


/*****************************************************************************
*  NAME:        fill_tx_message()
*
*  DESCRIPTION: This prototpye fills the Transmit FIFO with incrementing pattern
*               and transmits packet.
* 
*  INPUTS:      address = defines the destination address or consumer.
*               length  = defines the length of the packet.  Must be between
*                         8 bytes and 1024 bytes.
*            
******************************************************************************/
void fill_tx_message
(
  uint32_t address,
  uint32_t length,
  uint32_t LoopType,   // LoopType = 1 then internal Loopback
                       // LoopType = 2 then external Loopback
  uint32_t TxBlaster       
)
{
  /* declare pointers */
  uint32_t *p_FPGA_revision_reg;
  uint32_t *p_FPGA_scratch_reg;
  volatile uint32_t *p_FPGA_tx_fifo_reg;
  volatile uint32_t *p_FPGA_rx_fifo_reg;
  uint32_t *p_FPGA_control_reg;
  volatile uint32_t *p_FPGA_interrupt_reg;
  uint32_t *p_FPGA_interrupt_mask_reg;
  volatile uint32_t *p_FPGA_status_reg;
  uint32_t *p_FPGA_high_addr_reg;
  uint32_t *p_FPGA_low_addr_reg;
  
  /* declare registers */
  uint32_t length_minus6;
  uint32_t address_high2txfifo;
  uint32_t address_low2txfifo;
  uint32_t address_high2reg;
  uint32_t address_low2reg;
  uint32_t length_shift;
  uint32_t data_count;

  uint32_t FPGA_int_read_data;
  uint32_t temp;
  
  p_FPGA_revision_reg        = (uint32_t)COMMSFPGA_TOP_0;
  p_FPGA_scratch_reg         = (uint32_t)COMMSFPGA_TOP_0 + 0x4;
  p_FPGA_tx_fifo_reg         = (uint32_t)COMMSFPGA_TOP_0 + 0x8;
  p_FPGA_rx_fifo_reg         = (uint32_t)COMMSFPGA_TOP_0 + 0xC;
  p_FPGA_control_reg         = (uint32_t)COMMSFPGA_TOP_0 + 0x10;
  p_FPGA_interrupt_reg       = (uint32_t)COMMSFPGA_TOP_0 + 0x14;
  p_FPGA_interrupt_mask_reg  = (uint32_t)COMMSFPGA_TOP_0 + 0x18;
  p_FPGA_status_reg          = (uint32_t)COMMSFPGA_TOP_0 + 0x1C;
  p_FPGA_high_addr_reg       = (uint32_t)COMMSFPGA_TOP_0 + 0x30;
  p_FPGA_low_addr_reg        = (uint32_t)COMMSFPGA_TOP_0 + 0x34;
  
  
  /* Clear Interrupts */
//  *p_FPGA_interrupt_reg = 0xFF;

  /* Correct length for header (4 bytes) and CRC (2 bytes) */
  length_minus6 = length - 6;
 // length_minus6 = length - 5;
  
  /* Put address in proper bits before placing into consumer length registers  */
  address_high2reg = address >> 8;
  address_low2reg  = address & 0x000000FF;
  
  *p_FPGA_high_addr_reg = address_high2reg; //0x00000002;
  *p_FPGA_low_addr_reg  = address_low2reg;  //0x000000A9;

  /* Create most significant bits of length to write to FIFO */
  length_shift = length >> 8;

  /* Put address in proper bits before placing into tx fifo  */

  address_high2txfifo = address >> 2;
  address_low2txfifo  = address << 6;

  /* Load address/consumer into tx fifo */
  *p_FPGA_tx_fifo_reg = address_high2txfifo; /* Write high bits of address */
  *p_FPGA_tx_fifo_reg = address_low2txfifo;  /* Write low bits of address  */

  *p_FPGA_tx_fifo_reg = length_shift;        /* Write MSB bits of length   */
  *p_FPGA_tx_fifo_reg = length;              /* Write LSB bits of length   */
  
  /* Load incrementing data pattern into tx fifo */
  for ( data_count = 0; data_count < length_minus6 + 1; data_count++ ) {
      *p_FPGA_tx_fifo_reg = data_count;  
  }
  
  /* Enable Control Register to Transmit Packet in Loop-back Mode */
  if ( LoopType == 1 ) {
        *p_FPGA_control_reg = 0x00000030;   // internal loopback
  }
  else if ( LoopType == 2 ) {
        *p_FPGA_control_reg = 0x00000022;   // external loopback
  } 
  else {
        *p_FPGA_control_reg = 0x00000020;   // No Loopback
  }

  /*
   * Poll for TX interrupt
   */
  FPGA_int_read_data = 0x00;
  while ( (FPGA_int_read_data & 0xB1) == 0x00 ) {

  /*
   * Check for interrupt type
   */
  FPGA_int_read_data= *p_FPGA_interrupt_reg;

  // TX FIFO UNDERRUN
    if ( (FPGA_int_read_data & 0x20) > 0x00 )  {
      *p_FPGA_interrupt_reg = 0x20; 
         MSS_UART_polled_tx_string( &g_mss_uart0, "\n\r  TX FIFO UNDERRUN INTERRUPT" );
       tx_fifo_reset();
  }

  // TX FIFO OVERFLOW
    if ( (FPGA_int_read_data & 0x10) > 0x00 )  {
      *p_FPGA_interrupt_reg = 0x10; 
       MSS_UART_polled_tx_string( &g_mss_uart0, "\n\r  TX FIFO OVERFLOW INTERRUPT" );
       tx_fifo_reset();
  }   
  
  // TX COLLISION DETECTED
    if ( (FPGA_int_read_data & 0x01) > 0x00 )  {
        *p_FPGA_interrupt_reg = 0x01; 
         MSS_UART_polled_tx_string( &g_mss_uart0, "\n\r  TX COLLISION INTERRUPT" );
    } 
  
    // TX PACKET AVAILABLE
    if ( (FPGA_int_read_data & 0x80) > 0x00 )  {
        *p_FPGA_interrupt_reg = 0x80; 
    }   

  }

  if (TxBlaster == 0 ) {
    /* Delay Loop */
      for ( data_count = 0; data_count < 0x0003FFFF; data_count++ ) {
    	temp = *p_FPGA_interrupt_reg; 
    }
  }
  
return;
             	
}

/*****************************************************************************
*  NAME:        tx_fifo_reset()
*
*  DESCRIPTION: This function reset the Transmit FIFO.
*
*  INPUTS:      NONE
*
******************************************************************************/
void tx_fifo_reset()
{
  /* declare pointers */
  uint32_t *p_FPGA_control_reg;
  uint32_t temp;

  /* declare registers */

  /* other variable declarations */
  uint32_t data_count;

  p_FPGA_control_reg         = (uint32_t)COMMSFPGA_TOP_0 + 0x10;

  /* Put TX FIFO into Reset */
  *p_FPGA_control_reg = 0x00000090;
  temp = *p_FPGA_control_reg;

  /* Wait                   */
  for ( data_count = 0; data_count < 0x500; data_count++ ) {

  }

  /* Take TX FIFO out of Reset */
  *p_FPGA_control_reg = 0x00000010;

return;

}

/*****************************************************************************
*  NAME:        rx_fifo_reset()
*
*  DESCRIPTION: This function resets the Receive FIFO.
*
*  INPUTS:      NONE
*
******************************************************************************/
void rx_fifo_reset()
{
  /* declare pointers */
  uint32_t *p_FPGA_control_reg;

  /* declare registers */

  /* other variable delarations */
  uint32_t data_count;

  p_FPGA_control_reg         = (uint32_t)COMMSFPGA_TOP_0 + 0x10;

  /* Put TX FIFO into Reset */
  *p_FPGA_control_reg = 0x00000050;

  /* Wait                   */
  for ( data_count = 0; data_count < 0x200; data_count++ ) {

  }

  /* Take TX FIFO out of Reset */
  *p_FPGA_control_reg = 0x00000010;

return;

}


/*****************************************************************************
*  NAME:        SW_reset()
*
*  DESCRIPTION: This function resets the FPGA Logic.
*
*  INPUTS:      NONE
*
******************************************************************************/
void SW_reset()
{
  /* declare pointers */

  /* declare registers */
  uint32_t gpio_outputs;

  /* other variable declarations */
  uint32_t data_count;

  /* Put FPGA Into Reset */
  MSS_GPIO_set_outputs( MSS_GPIO_28_MASK );

  /* Wait                   */
  for ( data_count = 0; data_count < 0x500; data_count++ ) {

  }

  /* Take FPGA out of Reset */
  gpio_outputs = MSS_GPIO_get_outputs();
  gpio_outputs &= ~( MSS_GPIO_28_MASK );
  MSS_GPIO_set_outputs( gpio_outputs );

return;

}

/*****************************************************************************
*  NAME:  check_rx_message()
*
*  DESCRIPTION: This prototpye reads the Receive FIFO checks the Consumer and
*               then compares the data with an incrementing pattern
*
*  INPUTS:      address = defines the destination address or consumer.
*               length  = defines the length of the packet.  Must be between
*                         8 bytes and 1024 bytes.
*
******************************************************************************/
int check_rx_message
(
  uint32_t address,
  uint32_t length,
  uint32_t supress
)
{
  /* Delcare Constants */
  const uint8_t ERROR_RxFail[]        = "\n\r !!!!!! FAILED RX PACKET";
  const uint8_t ERROR_RxPass[]        = "\n\r PASS RX PACKET";
  const uint8_t ERROR_Consumer_High[]   = "\n\r CONSUMER HIGH ADDRESS FAIL";
  const uint8_t ERROR_Consumer_Low[]    = "\n\r CONSUMER LOW ADDRESS FAIL";
  const uint8_t ERROR_Length_High[]     = "\n\r LENGTH HIGH ADDRESS FAIL";
  const uint8_t ERROR_Length_Low[]      = "\n\r LENGTH LOW ADDRESS FAIL";
  const uint8_t ERROR_Data[]            = "\n\r DATA FAIL";

  /* declare pointers */
  volatile uint32_t *p_FPGA_rx_fifo_reg;
  volatile uint32_t *p_FPGA_status_reg;
  volatile uint32_t *p_FPGA_interrupt_reg;

  /* declare registers */
  uint32_t length_minus6;
  uint32_t address_high;
  uint32_t address_low;
  uint32_t length_shift;
  uint32_t length_mask;
  uint32_t data_count;
  uint32_t data_count_masked;
  uint32_t data_fail;

  uint32_t FPGA_rx_read_data;
  uint32_t FPGA_int_read_data;
  uint32_t FPGA_stat_reg_data;

  uint32_t temp;

  p_FPGA_rx_fifo_reg         = (uint32_t)COMMSFPGA_TOP_0 + 0xC;
  p_FPGA_status_reg          = (uint32_t)COMMSFPGA_TOP_0 + 0x1C;
  p_FPGA_interrupt_reg       = (uint32_t)COMMSFPGA_TOP_0 + 0x14;
 
  /*
   * Correct length for header (4 bytes) and CRC (2 bytes)
   */
  length_minus6 = length - 6;

  /*
   * Put address in proper bits before reading from rx fifo
   */
  address_high = address >> 2;
  address_low  = ( address << 6 ) & 0x000000FF;

  /*
   * Create most significant bits of length
   */
  length_shift = length >> 8;
  length_mask  = length & 0x000000FF;

  /*
   * Poll Status Register for RX PACKET AVAILABLE or Error Condition
   */
  FPGA_stat_reg_data = 0x00;
  FPGA_int_read_data = 0x00;
  
  while ( (FPGA_int_read_data & 0x0E == 0x00) && 
          (FPGA_stat_reg_data & 0x10 == 0x00) ) {

    FPGA_stat_reg_data = *p_FPGA_status_reg    & 0x10;
    FPGA_int_read_data = *p_FPGA_interrupt_reg & 0x0E;
  }
   
    // RX FIFO UNDERRUN
    if ( (FPGA_int_read_data & 0x08) > 0x00 )  {
        *p_FPGA_interrupt_reg = 0x08; 
         MSS_UART_polled_tx_string( &g_mss_uart0, "\n\r  RX FIFO UNDERRUN INTERRUPT" );
    }  
     
    // RX FIFO OVERFLOW
    if ( (FPGA_int_read_data & 0x04) > 0x00 )  {
        *p_FPGA_interrupt_reg = 0x04; 
         MSS_UART_polled_tx_string( &g_mss_uart0, "\n\r  RX FIFO OVERFLOW INTERRUPT" );
    } 
     
    // RX CRC ERROR
    if ( (FPGA_int_read_data & 0x02) > 0x00 )  {
        *p_FPGA_interrupt_reg = 0x02; 
         MSS_UART_polled_tx_string( &g_mss_uart0, "\n\r  RX CRC ERROR INTERRUPT" );
    } 
    
    // Receive Packet Available
    if ( (FPGA_stat_reg_data & 0x10) > 0x00 )  {
        *p_FPGA_interrupt_reg = 0x40; 
    }
  
  /*
   * Read first byte of rx FIFO  = high address/consumer and compare
   */
  data_fail = 0;

  FPGA_rx_read_data = *p_FPGA_rx_fifo_reg;
  
  if ( FPGA_rx_read_data != address_high ) {
//    MSS_UART_polled_tx( &g_mss_uart0, ERROR_Consumer_High, sizeof(ERROR_Consumer_High) );
    data_fail = 1;
  }

  /*
   * Read second byte of rx FIFO = low address/consumer and compare
   */
  FPGA_rx_read_data = *p_FPGA_rx_fifo_reg;
  if ( FPGA_rx_read_data != address_low ) {
//    MSS_UART_polled_tx( &g_mss_uart0, ERROR_Consumer_Low, sizeof(ERROR_Consumer_Low) );
    data_fail = 1;
  }

  /*
   * Read third byte of rx FIFO  = high length and compare
   */
  FPGA_rx_read_data = *p_FPGA_rx_fifo_reg;
  if ( FPGA_rx_read_data != length_shift ) {
//    MSS_UART_polled_tx( &g_mss_uart0, ERROR_Length_High, sizeof(ERROR_Length_High) );
    data_fail = 1;
 }

  /*
   * Read forth byte of rx FIFO  = low length and compare
   */
  FPGA_rx_read_data = *p_FPGA_rx_fifo_reg;
  if ( FPGA_rx_read_data != length_mask ) {
//    MSS_UART_polled_tx( &g_mss_uart0, ERROR_Length_Low, sizeof(ERROR_Length_Low) );
    data_fail = 1;
  }

  /*
   * Read remaining bytes of rx FIFO and compare
   */
  for ( data_count = 0; data_count < length_minus6 + 1; data_count++ ) {
         FPGA_rx_read_data = *p_FPGA_rx_fifo_reg;
         data_count_masked = data_count & 0x000000FF;
      if ( FPGA_rx_read_data != data_count_masked ) {
 //         MSS_UART_polled_tx( &g_mss_uart0, ERROR_Data, sizeof(ERROR_Data) );
          data_fail = 1;
      }
  }

  /*
   * Read CRC bytes (qty 2) from FIFO
   */
  FPGA_rx_read_data = *p_FPGA_rx_fifo_reg;
  FPGA_rx_read_data = *p_FPGA_rx_fifo_reg;

  /*
   * Check for interrupt type
   */
  
  /*
   * Print Message if Receive Packet Pass/Failed.
   */
  if ( data_fail == 1 ) {
      MSS_UART_polled_tx( &g_mss_uart0, ERROR_RxFail, sizeof(ERROR_RxFail) );
      return(1);
  }
  else {
      if (supress == 0) {
        MSS_UART_polled_tx( &g_mss_uart0, ERROR_RxPass, sizeof(ERROR_RxPass));
      }
      return(0);
  }

}

/********************************************************************************
*  NAME:        tohexstring()
*
*  DESCRIPTION: This function converts an integer to a hexidecimal string.
*
*  INPUTS:      str        = passes the sting buffer to this function.
*               num        = provides the integer number.
*
********************************************************************************/
void tohexstring(char str[], int num)
{
    uint32_t quotient;
    int i = 7, j = 0;
    uint8_t temp = 0;

    quotient = num;

    // clear string
    for (j = 0; j < 8; j++)
    {
        str[j] = '/0';
    }

    while(quotient!=0){
         temp = quotient % 16;

      //To convert integer into character
      if( temp < 10)
         temp = temp + 48;
      else
         temp = temp + 55;

      str[i] = (char)temp;
      i--;
 //     MSS_UART_polled_tx( &g_mss_uart0, str_temp, sizeof(str_temp) );

      quotient = quotient / 16;
  }
}

/********************************************************************************
*  NAME:        packet_loopback()
*
*  DESCRIPTION: This function transmits a packet which loopbacks to the
*               receiver.  It is then checked for validity.  An incrementing
*               pattern is used for the data.
*
*  INPUTS:      address    = defines the destination address or consumer.
*               length     = defines the starting length of the packet.
*                            The packet is incremented in size by one for each
*                            packet looped back.  Packet size must be a minimum
*                            of 8 bytes and not exceed 1024 bytes.
*
*               iterations = defines the number of packets to loop back.
*
********************************************************************************/
void packet_loopback
(
  uint32_t address,
  uint32_t length,
  uint32_t iterations,
  uint32_t LoopType,
  uint32_t TxBlaster
)
{
  /* declare variables */
  uint32_t iter;
  uint32_t packet_length;
  uint32_t NumFailures = 0;
  uint32_t check_rx_message_result;

  /* declare registers */

  iter = iterations;

  /* loopback packet with varing sizes */
  for ( iter = 0; iter < iterations; iter++ ) {
    packet_length = length + iter;
    fill_tx_message  ( address, packet_length, LoopType, TxBlaster );

    if ( check_rx_message ( address, packet_length, 1 ) == 1 )
   	NumFailures++;
  }
  
  if ( NumFailures == 0 )
    MSS_UART_polled_tx_string( &g_mss_uart0, "\n\r ALL PACKETS PASSED... \n\r" ); 

return;

}

/*****************************************************************************
*  NAME:        b2b_single_tx_message_send()
*
*  DESCRIPTION: This prototpye fills the Transmit FIFO with incrementing pattern
*               and sends to the rail.  It is used for board to board communication, 
*               single packet transmission as opposed to loopback.
* 
*  INPUTS:      address = defines the destination address or consumer.
*               length  = defines the length of the packet.  Must be between
*                         8 bytes and 1024 bytes.
*               TxBlaster = if 0 then implement delay loop, if 1 then wait for
*                           Tx Complete and send next packet.
*            
******************************************************************************/
void b2b_single_tx_message_send
(
  uint32_t address,
  uint32_t length,
  uint32_t TxBlaster
)
{
  /* declare pointers */
  volatile uint32_t *p_FPGA_tx_fifo_reg;
  uint32_t *p_FPGA_control_reg;
  volatile uint32_t *p_FPGA_interrupt_reg;
  uint32_t *p_FPGA_high_addr_reg;
  uint32_t *p_FPGA_low_addr_reg;
  
  /* declare registers */
  uint32_t length_minus6;
  uint32_t address_high2txfifo;
  uint32_t address_low2txfifo;
  uint32_t address_high2reg;
  uint32_t address_low2reg;
  uint32_t length_shift;
  uint32_t data_count;

  uint32_t FPGA_int_read_data;
  uint32_t temp;
  
  p_FPGA_tx_fifo_reg         = (uint32_t)COMMSFPGA_TOP_0 + 0x8;
  p_FPGA_control_reg         = (uint32_t)COMMSFPGA_TOP_0 + 0x10;
  p_FPGA_interrupt_reg       = (uint32_t)COMMSFPGA_TOP_0 + 0x14;
  p_FPGA_high_addr_reg       = (uint32_t)COMMSFPGA_TOP_0 + 0x30;
  p_FPGA_low_addr_reg        = (uint32_t)COMMSFPGA_TOP_0 + 0x34;

  /* Clear Interrupts */
  *p_FPGA_interrupt_reg = 0xFF;
    
  /* Correct length for header (4 bytes) and CRC (2 bytes) */
  length_minus6 = length - 6;
  
  /* Put address in proper bits before placing into tx fifo
   * and consumer length registers  */
  address_high2reg = address >> 8;
  address_low2reg  = address & 0x000000FF;
  
  *p_FPGA_high_addr_reg = address_high2reg; //0x00000002;
  *p_FPGA_low_addr_reg  = address_low2reg;  //0x000000A9;

  /* Create most significant bits of length to write to FIFO */
  length_shift = length >> 8;

  /* Put address in proper bits before placing into tx fifo  */

  address_high2txfifo = address >> 2;
  address_low2txfifo  = address << 6;

  /* Load address/consumer into tx fifo */
  *p_FPGA_tx_fifo_reg = address_high2txfifo;     /* Write high bits of address */
  *p_FPGA_tx_fifo_reg = address_low2txfifo;      /* Write low bits of address  */

  *p_FPGA_tx_fifo_reg = length_shift;     /* Write MSB bits of length   */
  *p_FPGA_tx_fifo_reg = length;           /* Write LSB bits of length   */
  
  /* Load incrementing data pattern into tx fifo */
  for ( data_count = 0; data_count < length_minus6 + 1; data_count++ ) {
      *p_FPGA_tx_fifo_reg = data_count;  
  }
  
  /* Enable Control Register to Transmit Packet */
  *p_FPGA_control_reg = 0x00000020;

  /*
   * Poll for TX complete
   */
  FPGA_int_read_data = 0x00;
  while ( FPGA_int_read_data == 0x00 ) {
	  temp = *p_FPGA_interrupt_reg;
    FPGA_int_read_data = temp & 0x80;
  }
  /*
  * Clear TX Complete Interrupt
  */
  *p_FPGA_interrupt_reg = 0x80;
  
  if (TxBlaster == 0 ) {
    /* Delay Loop */
      for ( data_count = 0; data_count < 0x0003FFFF; data_count++ ) {
    	temp = *p_FPGA_interrupt_reg; 
    }
  }
  
return;
             	
}


/*****************************************************************************
*  NAME:  b2b_single_rx_message_check()
*
*  DESCRIPTION: This prototpye reads the Receive FIFO checks the Consumer and
*               then compares the data with an incrementing pattern.  It is 
*               used for board to board communication, single packet reception
*               as opposed to loopback.
*
*  INPUTS:      address = defines the destination address or consumer.
*               length  = defines the length of the packet.  Must be between
*                         8 bytes and 1024 bytes.
*
******************************************************************************/
int b2b_single_rx_message_check
(
  uint32_t address,
  uint32_t length
)
{
  /* Delcare Constants */
  const uint8_t ERROR_RxFail[]        = "\n\r !!!!!! FAILED RX PACKET";
  const uint8_t ERROR_RxPass[]        = "\n\r PASS RX PACKET";


  /* declare pointers */
  volatile uint32_t *p_FPGA_rx_fifo_reg;
  uint32_t *p_FPGA_control_reg;
  volatile uint32_t *p_FPGA_interrupt_reg;
  uint32_t *p_FPGA_high_addr_reg;
  uint32_t *p_FPGA_low_addr_reg;
  volatile uint32_t *p_FPGA_status_reg;

  /* declare registers */
  uint32_t length_minus6;
  uint32_t address_high;
  uint32_t address_low;
  uint32_t address_high2reg;
  uint32_t address_low2reg;
  uint32_t length_shift;
  uint32_t length_mask;
  uint32_t data_count;
  uint32_t data_count_masked;
  uint32_t data_fail;

  uint32_t FPGA_rx_read_data;
  uint32_t FPGA_int_read_data;
  uint32_t FPGA_stat_reg_data;
  
  uint32_t x;
  uint32_t temp;
  uint32_t trigger;
  char     UART_in_string [8];

  p_FPGA_rx_fifo_reg         = (uint32_t)COMMSFPGA_TOP_0 + 0xC;
  p_FPGA_control_reg         = (uint32_t)COMMSFPGA_TOP_0 + 0x10;
  p_FPGA_interrupt_reg       = (uint32_t)COMMSFPGA_TOP_0 + 0x14;
  p_FPGA_status_reg          = (uint32_t)COMMSFPGA_TOP_0 + 0x1C;
  p_FPGA_high_addr_reg       = (uint32_t)COMMSFPGA_TOP_0 + 0x30;
  p_FPGA_low_addr_reg        = (uint32_t)COMMSFPGA_TOP_0 + 0x34;

  /* Clear Interrupts */
  *p_FPGA_interrupt_reg = 0xFF;
  
  /* Put address in proper bits before placing into consumer length registers  */
  address_high2reg = address >> 8;
  address_low2reg  = address & 0x000000FF;
  
  *p_FPGA_high_addr_reg = address_high2reg;
  *p_FPGA_low_addr_reg  = address_low2reg;
      
  /*
  Ensure internal Loopback is off
  */
  *p_FPGA_control_reg = 0x00000000;
  
  /*
   * Correct length for header (4 bytes) and CRC (2 bytes)
   */
  length_minus6 = length - 6;

  /*
   * Put address in proper bits before reading from rx fifo
   */
  address_high = address >> 2;
  address_low  = ( address << 6 ) & 0x000000FF;

  /*
   * Create most significant bits of length
   */
  length_shift = length >> 8;
  length_mask  = length & 0x000000FF;
  
  /*
   * Poll Status Register for RX PACKET AVAILABLE
   */
  FPGA_stat_reg_data = 0x00;
  
  while ( (FPGA_stat_reg_data & 0x10) == 0x00 ) {
    FPGA_stat_reg_data = *p_FPGA_status_reg    & 0x10;
  }
  
  /*
  * Clear RX Complete Interrupt
  */
  *p_FPGA_interrupt_reg = 0x40;
  
  /*
   * Read first byte of rx FIFO  = high address/consumer and compare
   */
  data_fail = 0;

  FPGA_rx_read_data = *p_FPGA_rx_fifo_reg;
  if ( FPGA_rx_read_data != address_high ) {
    MSS_UART_polled_tx_string( &g_mss_uart0, "\n\r High Address Fail  " );

  // Print Interrupt Status
    MSS_UART_polled_tx_string( &g_mss_uart0,     "  FPGA Interrupt Register:   0x" );
    temp = *p_FPGA_interrupt_reg;
    tohexstring(UART_in_string, temp);
    MSS_UART_polled_tx( &g_mss_uart0, UART_in_string, sizeof(UART_in_string) );
    
  // Print Data Read and Expected
    MSS_UART_polled_tx_string( &g_mss_uart0,     "    Expected:   0x" );
    tohexstring(UART_in_string, address_high);
    MSS_UART_polled_tx( &g_mss_uart0, UART_in_string, sizeof(UART_in_string) );
    MSS_UART_polled_tx_string( &g_mss_uart0,     "    Actual:   0x" );
    tohexstring(UART_in_string, FPGA_rx_read_data);
    MSS_UART_polled_tx( &g_mss_uart0, UART_in_string, sizeof(UART_in_string) );
  
    data_fail = 1;
  }

  /*
   * Read second byte of rx FIFO = low address/consumer and compare
   */
  FPGA_rx_read_data = *p_FPGA_rx_fifo_reg;
  if ( FPGA_rx_read_data != address_low ) {
    MSS_UART_polled_tx_string( &g_mss_uart0, "\n\r Low Address Fail   " );

  // Print Interrupt Status
    MSS_UART_polled_tx_string( &g_mss_uart0,     "  FPGA Interrupt Register:   0x" );
    temp = *p_FPGA_interrupt_reg;
    tohexstring(UART_in_string, temp);
    MSS_UART_polled_tx( &g_mss_uart0, UART_in_string, sizeof(UART_in_string) );
    
  // Print Data Read and Expected
    MSS_UART_polled_tx_string( &g_mss_uart0,     "    Expected:   0x" );
    tohexstring(UART_in_string, address_low);
    MSS_UART_polled_tx( &g_mss_uart0, UART_in_string, sizeof(UART_in_string) );
    MSS_UART_polled_tx_string( &g_mss_uart0,     "    Actual:   0x" );
    tohexstring(UART_in_string, FPGA_rx_read_data);
    MSS_UART_polled_tx( &g_mss_uart0, UART_in_string, sizeof(UART_in_string) );
  
    data_fail = 1;
  }

  /*
   * Read third byte of rx FIFO  = high length and compare
   */
  FPGA_rx_read_data = *p_FPGA_rx_fifo_reg;
  if ( FPGA_rx_read_data != length_shift ) {
	  MSS_UART_polled_tx_string( &g_mss_uart0, "\n\r High Length Fail   " );

  // Print Interrupt Status
    MSS_UART_polled_tx_string( &g_mss_uart0,     "  FPGA Interrupt Register:   0x" );
    temp = *p_FPGA_interrupt_reg;
    tohexstring(UART_in_string, temp);
    MSS_UART_polled_tx( &g_mss_uart0, UART_in_string, sizeof(UART_in_string) );
    
  // Print Data Read and Expected
    MSS_UART_polled_tx_string( &g_mss_uart0,     "    Expected:   0x" );
    tohexstring(UART_in_string, length_shift);
    MSS_UART_polled_tx( &g_mss_uart0, UART_in_string, sizeof(UART_in_string) );
    MSS_UART_polled_tx_string( &g_mss_uart0,     "    Actual:   0x" );
    tohexstring(UART_in_string, FPGA_rx_read_data);
    MSS_UART_polled_tx( &g_mss_uart0, UART_in_string, sizeof(UART_in_string) );
  
    data_fail = 1;
 }

  /*
   * Read forth byte of rx FIFO  = low length and compare
   */
  FPGA_rx_read_data = *p_FPGA_rx_fifo_reg;
  if ( FPGA_rx_read_data != length_mask ) {
	  MSS_UART_polled_tx_string( &g_mss_uart0, "\n\r Low Length Fail    " );

  // Print Interrupt Status
    MSS_UART_polled_tx_string( &g_mss_uart0,     "  FPGA Interrupt Register:   0x" );
    temp = *p_FPGA_interrupt_reg;
    tohexstring(UART_in_string, temp);
    MSS_UART_polled_tx( &g_mss_uart0, UART_in_string, sizeof(UART_in_string) );
    
  // Print Data Read and Expected
    MSS_UART_polled_tx_string( &g_mss_uart0,     "    Expected:   0x" );
    tohexstring(UART_in_string, length_mask);
    MSS_UART_polled_tx( &g_mss_uart0, UART_in_string, sizeof(UART_in_string) );
    MSS_UART_polled_tx_string( &g_mss_uart0,     "    Actual:   0x" );
    tohexstring(UART_in_string, FPGA_rx_read_data);
    MSS_UART_polled_tx( &g_mss_uart0, UART_in_string, sizeof(UART_in_string) );
  
    data_fail = 1;
  }

  /*
   * Read remaining bytes of rx FIFO and compare
   */
  for ( data_count = 0; data_count < length_minus6 + 1; data_count++ ) {
         FPGA_rx_read_data = *p_FPGA_rx_fifo_reg;
         data_count_masked = data_count & 0x000000FF;
      if ( FPGA_rx_read_data != data_count_masked ) {
          MSS_UART_polled_tx_string( &g_mss_uart0, "\n\r Data Fail          " );

        // Print Interrupt Status
          MSS_UART_polled_tx_string( &g_mss_uart0,     "  FPGA Interrupt Register:   0x" );
          temp = *p_FPGA_interrupt_reg;
          tohexstring(UART_in_string, temp);
          MSS_UART_polled_tx( &g_mss_uart0, UART_in_string, sizeof(UART_in_string) );
          
        // Print Data Read and Expected
          MSS_UART_polled_tx_string( &g_mss_uart0,     "    Expected:   0x" );
          tohexstring(UART_in_string, data_count_masked);
          MSS_UART_polled_tx( &g_mss_uart0, UART_in_string, sizeof(UART_in_string) );
          MSS_UART_polled_tx_string( &g_mss_uart0,     "    Actual:   0x" );
          tohexstring(UART_in_string, FPGA_rx_read_data);
          MSS_UART_polled_tx( &g_mss_uart0, UART_in_string, sizeof(UART_in_string) );
  
          data_fail = 1;
      }
  }

  /*
   * Read CRC bytes (qty 2) from FIFO
   */
  FPGA_rx_read_data = *p_FPGA_rx_fifo_reg;
  FPGA_rx_read_data = *p_FPGA_rx_fifo_reg;

  /*
   * Print Message if Receive Packet Pass/Failed.
   */
  if ( data_fail == 1 ) {
      MSS_UART_polled_tx( &g_mss_uart0, ERROR_RxFail, sizeof(ERROR_RxFail) );
      return(1);
  }
  else {
      MSS_UART_polled_tx( &g_mss_uart0, ERROR_RxPass, sizeof(ERROR_RxPass) );
      return(0);
  }
}

/********************************************************************************
*  NAME:        b2b_multiple_tx_message_send()
*
*  DESCRIPTION: This function transmits Multiple packets.  An incrementing
*               pattern is used for the data.
*
*  INPUTS:      address    = defines the destination address or consumer.
*               length     = defines the starting length of the packet.
*                            The packet is incremented in size by one for each
*                            packet looped back.  Packet size must be a minimum
*                            of 8 bytes and not exceed 1024 bytes.
*
*               iterations = defines the number of packets to loop back.
*               TxBlaster  = if 0 then implement delay loop, if 1 then wait for
*                            Tx Complete and send next packet.
*
********************************************************************************/
void b2b_multiple_tx_message_send
(
  uint32_t address,
  uint32_t length,
  uint32_t iterations,
  uint32_t TxBlaster
)
{
  /* declare variables */
  uint32_t iter;
  uint32_t packet_length;
  uint32_t NumFailures = 0;
  uint32_t check_rx_message_result;
  uint32_t uart0_rx_size;
  
  // 022216
  uint8_t  uart0_rx_buff[1024];
  
  /* declare registers */

  iter = iterations;


  /* loopback packet with varing sizes */
  for ( iter = 0; iter < iterations; iter++ ) {
    packet_length = length + iter;
    b2b_single_tx_message_send ( address, packet_length, TxBlaster );
  }

return;

}

/********************************************************************************
*  NAME:        b2b_multiple_rx_message_check()
*
*  DESCRIPTION: This function Receives and Checks Multiple packets.
*               An incrementing pattern is used for the checked data.
*
*  INPUTS:      address    = defines the destination address or consumer.
*               length     = defines the starting length of the packet.
*                            The packet is incremented in size by one for each
*                            packet looped back.  Packet size must be a minimum
*                            of 8 bytes and not exceed 1024 bytes.
*
*               iterations = defines the number of packets to loop back.
*
********************************************************************************/
void b2b_multiple_rx_message_check
(
  uint32_t address,
  uint32_t length,
  uint32_t iterations
)
{
  /* declare variables */
  uint32_t iter;
  uint32_t packet_length;
  uint32_t NumFailures = 0;
  uint32_t check_rx_message_result;

  /* declare registers */

  iter = iterations;

  /* loopback packet with varing sizes */
  for ( iter = 0; iter < iterations; iter++ ) {
	packet_length = length + iter;
    if ( b2b_single_rx_message_check ( address, packet_length ) == 1 )
   	NumFailures++;
  }

  if ( NumFailures == 0 )
    MSS_UART_polled_tx_string( &g_mss_uart0, "\n\r ALL PACKETS PASSED... \n\r" );

return;

}




/********************************************************************************
*  NAME:        b2b_multiple_tx_message_blast()
*
*  DESCRIPTION: This function transmits Multiple packets.  An incrementing
*               pattern is used for the data.
*
*  INPUTS:      address    = defines the destination address or consumer.
*               length     = defines the starting length of the packet.
*                            The packet is incremented in size by one for each
*                            packet looped back.  Packet size must be a minimum
*                            of 8 bytes and not exceed 1024 bytes.
*               iterations = defines the number of packets to loop back.
*               TxBlaster  = if 0 then implement delay loop, if 1 then wait for
*                            Tx Complete and send next packet.
*
********************************************************************************/
void b2b_multiple_tx_message_blast
(
  uint32_t address,
  uint32_t length,
  uint32_t iterations,
  uint32_t TxBlaster
)
{
  /* declare variables */
  uint32_t iter;
  uint32_t packet_length;
  uint32_t NumFailures = 0;
  uint32_t check_rx_message_result;
  uint32_t uart0_rx_size;
  
  // 022216
  uint8_t  uart0_rx_buff[1024];
  
  /* declare registers */

  iter = iterations;


  /* loopback packet with varing sizes */
  for ( iter = 0; iter < iterations; iter++ ) {
    packet_length = 1020;
    b2b_single_tx_message_send ( address, packet_length, TxBlaster );
  }

return;

}


/********************************************************************************
*  NAME:        blaster_packet_loopback()
*
*  DESCRIPTION: This function transmits a packet which loopbacks to the
*               receiver.  It is then checked for validity.  An incrementing
*               pattern is used for the data.
*
*  INPUTS:      address    = defines the destination address or consumer.
*               length     = defines the starting length of the packet.
*                            The packet is incremented in size by one for each
*                            packet looped back.  Packet size must be a minimum
*                            of 8 bytes and not exceed 1024 bytes.
*
*               iterations = defines the number of packets to loop back.
*
********************************************************************************/
void blaster_packet_loopback
(
  uint32_t address,
  uint32_t length,
  uint32_t iterations,
  uint32_t LoopType,
  uint32_t TxBlaster
)
{
  /* declare variables */
  uint32_t iter;
  uint32_t packet_length;
  uint32_t NumFailures = 0;
  uint32_t check_rx_message_result;
  uint32_t packet_iter;
  uint32_t packet_iterations;

  /* declare registers */
  packet_iterations = 0x000FFFFF;
  iter              = iterations;

  /* loopback packet with varing sizes */
  for ( packet_iter = 0; packet_iter < packet_iterations; packet_iter++ ) {
    for ( iter = 0; iter < iterations; iter++  ) {
      packet_length = length + iter;
      fill_tx_message  ( address, packet_length, LoopType, TxBlaster );
    }
    
    for ( iter = 0; iter < iterations; iter++ ) {
      packet_length = length + iter;
      if ( check_rx_message ( address, packet_length, 1 ) == 1 )
   	  NumFailures++;
   	}
  }
  
  if ( NumFailures == 0 )
    MSS_UART_polled_tx_string( &g_mss_uart0, "\n\r ALL PACKETS PASSED... \n\r" ); 

return;

}

/********************************************************************************
*  NAME:        TX_blaster_packet()
*
*  DESCRIPTION: This function transmits a packet which loopbacks to the
*               receiver.  It is then checked for validity.  An incrementing
*               pattern is used for the data.
*
*  INPUTS:      address    = defines the destination address or consumer.
*               length     = defines the starting length of the packet.
*                            The packet is incremented in size by one for each
*                            packet looped back.  Packet size must be a minimum
*                            of 8 bytes and not exceed 1024 bytes.
*
*               iterations = defines the number of packets to loop back.
*
********************************************************************************/
void TX_blaster_packet
(
  uint32_t address,
  uint32_t length,
  uint32_t iterations,
  uint32_t LoopType,
  uint32_t TxBlaster
)
{
  /* declare variables */
  uint32_t packet_length;
  uint32_t packet_iter;
  uint32_t packet_iterations;

  /* declare registers */
  packet_iterations = iterations;

  /* loopback packet with varing sizes */
    for ( packet_iter = 0; packet_iter < packet_iterations; packet_iter++ ) {
      packet_length = length + packet_iter;
      fill_tx_message  ( address, packet_length, LoopType, TxBlaster );
    }
  
return;

}



/********************************************************************************
*  NAME:        RX_blaster_packet()
*
*  DESCRIPTION: This function receives a packet from another board.  
*               It is then checked for validity.  An incrementing
*               pattern is used for the data.
*
*  INPUTS:      address    = defines the destination address or consumer.
*               length     = defines the starting length of the packet.
*                            The packet is incremented in size by one for each
*                            packet looped back.  Packet size must be a minimum
*                            of 8 bytes and not exceed 1024 bytes.
*
*               iterations = defines the number of packets to loop back.
*
********************************************************************************/
void RX_blaster_packet
(
  uint32_t address,
  uint32_t length,
  uint32_t iterations
)
{
  /* declare variables */
  uint32_t packet_length;
  uint32_t NumFailures = 0;
  uint32_t packet_iter;
  uint32_t packet_iterations;

  /* declare registers */
  packet_iterations = iterations;
    
    for ( packet_iter = 0; packet_iter < packet_iterations; packet_iter++ ) {
      packet_length = length + packet_iter;
      if ( check_rx_message ( address, packet_length, 0 ) == 1 )
   	  NumFailures++;
   	}
  
  if ( NumFailures == 0 )
    MSS_UART_polled_tx_string( &g_mss_uart0, "\n\r ALL PACKETS PASSED... \n\r" ); 

return;

}
