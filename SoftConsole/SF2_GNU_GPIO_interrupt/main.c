/*******************************************************************************
 * (c) Copyright 2013 Microsemi SoC Products Group.  All rights reserved.
 *
 * SmartFusion2 microcontroller subsystem (MSS) GPIO interrupt example.
 *
 * Please refer to the file README.txt for further details about this example.
 *
 * SVN $Revision: 5511 $
 * SVN $Date: 2013-03-29 18:52:31 +0000 (Fri, 29 Mar 2013) $
 */
#include "drivers/mss_gpio/mss_gpio.h"
#include "drivers/mss_uart/mss_uart.h"
#include "CMSIS/system_m2sxxx.h"

/*==============================================================================
  Messages displayed over the UART.
 */
const uint8_t g_greeting_msg[] =
"\r\n\r\n\
**********************************************************************\r\n\
**************** SmartFusion2 GPIO Interrupt Example *****************\r\n\
**********************************************************************\r\n\
 This example project demonstrates the use of the SmartFusion2\r\n\
 GPIO interrupt.\r\n";

const uint8_t g_instructions_msg[] =
"\r\n\
 Press one of the switches on the board to generate an interrupt. The\r\n\
 interrupt service routine will display a message when the interrupt\r\n\
 occurs. Each switch generates an interrupt of a different type:\r\n\
    - SW1: edge positive interrupt.\r\n\
    - SW2: edge negative interrupt. \r\n\
    - SW3: both edge positive and negative interrupt. \r\n\
    - SW4: level low interrupt. \r\n\
 \r\n";

 const uint8_t g_edge_positive_irq_msg[] =
"\r\n\r\n\
----------------------------------------------------------------------\r\n\
!!!!!!!!!!!!!!!!!!!! Edge Positive GPIO Interrupt !!!!!!!!!!!!!!!!!!!!\r\n\
----------------------------------------------------------------------\r\n";

 const uint8_t g_edge_negative_irq_msg[] =
"\r\n\r\n\
----------------------------------------------------------------------\r\n\
!!!!!!!!!!!!!!!!!!!! Edge Negative GPIO Interrupt !!!!!!!!!!!!!!!!!!!!\r\n\
----------------------------------------------------------------------\r\n";

 const uint8_t g_edge_neg_pos_irq_msg[] =
"\r\n\r\n\
----------------------------------------------------------------------\r\n\
!!!!!!!!!!!!! Edge Positive and Negative GPIO Interrupt !!!!!!!!!!!!!!\r\n\
----------------------------------------------------------------------\r\n";

 const uint8_t g_level_low_irq_msg[] =
"\r\n\r\n\
----------------------------------------------------------------------\r\n\
!!!!!!!!!!!!!!!!!!!!!! Level Low GPIO Interrupt !!!!!!!!!!!!!!!!!!!!!!\r\n\
----------------------------------------------------------------------\r\n";

/*==============================================================================
  Private functions.
 */
static void display_greeting(void);

/*==============================================================================
  UART selection.
  Replace the line below with this one if you want to use UART0 instead of
  UART1:
  mss_uart_instance_t * const gp_my_uart = &g_mss_uart1;
 */
mss_uart_instance_t * const gp_my_uart = &g_mss_uart0;

/*==============================================================================
 * main() function.
 */
int main()
{
    /*
     * Initialize MSS GPIOs.
     */
    MSS_GPIO_init();
    
    /*
     * MMUART initialization
     */
    MSS_UART_init(gp_my_uart,
                  MSS_UART_57600_BAUD,
                  MSS_UART_DATA_8_BITS | MSS_UART_NO_PARITY | MSS_UART_ONE_STOP_BIT);
                  
    /*
     * Display greeting message.
     */
    display_greeting();
    
    /*
     * Configure MSS GPIOs.
     */
    MSS_GPIO_config(MSS_GPIO_8 , MSS_GPIO_INPUT_MODE | MSS_GPIO_IRQ_EDGE_POSITIVE);
    MSS_GPIO_config(MSS_GPIO_9 , MSS_GPIO_INPUT_MODE | MSS_GPIO_IRQ_EDGE_NEGATIVE);
    MSS_GPIO_config(MSS_GPIO_10 , MSS_GPIO_INPUT_MODE | MSS_GPIO_IRQ_EDGE_BOTH);
    MSS_GPIO_config(MSS_GPIO_11 , MSS_GPIO_INPUT_MODE | MSS_GPIO_IRQ_LEVEL_LOW);
    
    /*
     * Enable interrupts.
     */
    MSS_GPIO_enable_irq(MSS_GPIO_8);
    MSS_GPIO_enable_irq(MSS_GPIO_9);
    MSS_GPIO_enable_irq(MSS_GPIO_10);
    MSS_GPIO_enable_irq(MSS_GPIO_11);
    
    /*
     * Infinite loop. Wait for interrupts to occur.
     */
    for(;;)
    {
        ;
    }
    
    return 0;
}

/*==============================================================================
  GPIO 8 interrupt service routine.
 */
void GPIO8_IRQHandler(void)
{
    MSS_UART_polled_tx_string(gp_my_uart, g_edge_positive_irq_msg);
    MSS_GPIO_clear_irq(MSS_GPIO_8);
};

/*==============================================================================
  GPIO 9 interrupt service routine.
 */
void GPIO9_IRQHandler(void)
{
    MSS_UART_polled_tx_string(gp_my_uart, g_edge_negative_irq_msg);
    MSS_GPIO_clear_irq(MSS_GPIO_9);
};

/*==============================================================================
  GPIO 10 interrupt service routine.
 */
void GPIO10_IRQHandler(void)
{
    MSS_UART_polled_tx_string(gp_my_uart, g_edge_neg_pos_irq_msg);
    MSS_GPIO_clear_irq(MSS_GPIO_10);
};

/*==============================================================================
  GPIO 11 interrupt service routine.
 */
void GPIO11_IRQHandler(void)
{
    MSS_UART_polled_tx_string(gp_my_uart, g_level_low_irq_msg);
    MSS_GPIO_clear_irq(MSS_GPIO_11);
};


/*==============================================================================
  Display greeting message when application is started.
 */
static void display_greeting(void)
{
    MSS_UART_polled_tx_string(gp_my_uart, g_greeting_msg);
    MSS_UART_polled_tx_string(gp_my_uart, g_instructions_msg);
}

