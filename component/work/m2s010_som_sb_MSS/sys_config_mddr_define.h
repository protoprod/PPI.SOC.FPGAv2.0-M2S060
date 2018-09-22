/*=============================================================*/
/* Created by Microsemi SmartDesign Sat Sep 22 10:29:42 2018   */
/*                                                             */
/* Warning: Do not modify this file, it may lead to unexpected */
/*          functional failures in your design.                */
/*                                                             */
/*=============================================================*/

#define MDDR_DDRC_DYN_SOFT_RESET_CR 0x0
#define MDDR_DDRC_RESERVED0 0x0
#define MDDR_DDRC_DYN_REFRESH_1_CR 0x1188
#define MDDR_DDRC_DYN_REFRESH_2_CR 0x290
#define MDDR_DDRC_DYN_POWERDOWN_CR 0x2
#define MDDR_DDRC_DYN_DEBUG_CR 0x0
#define MDDR_DDRC_MODE_CR 0x81
#define MDDR_DDRC_ADDR_MAP_BANK_CR 0x99f
#define MDDR_DDRC_ECC_DATA_MASK_CR 0x0
#define MDDR_DDRC_ADDR_MAP_COL_1_CR 0x3333
#define MDDR_DDRC_ADDR_MAP_COL_2_CR 0xffff
#define MDDR_DDRC_ADDR_MAP_COL_3_CR 0x3300
#define MDDR_DDRC_ADDR_MAP_ROW_1_CR 0x7777
#define MDDR_DDRC_ADDR_MAP_ROW_2_CR 0x777
#define MDDR_DDRC_INIT_1_CR 0x1
#define MDDR_DDRC_CKE_RSTN_CYCLES_1_CR 0x4200
#define MDDR_DDRC_CKE_RSTN_CYCLES_2_CR 0x8
#define MDDR_DDRC_INIT_MR_CR 0x32
#define MDDR_DDRC_INIT_EMR_CR 0x2
#define MDDR_DDRC_INIT_EMR2_CR 0x0
#define MDDR_DDRC_INIT_EMR3_CR 0x0
#define MDDR_DDRC_DRAM_BANK_TIMING_PARAM_CR 0x0
#define MDDR_DDRC_DRAM_RD_WR_LATENCY_CR 0x23
#define MDDR_DDRC_DRAM_RD_WR_PRE_CR 0x235
#define MDDR_DDRC_DRAM_MR_TIMING_PARAM_CR 0x0
#define MDDR_DDRC_DRAM_RAS_TIMING_CR 0x20
#define MDDR_DDRC_DRAM_RD_WR_TRNARND_TIME_CR 0x178
#define MDDR_DDRC_DRAM_T_PD_CR 0x0
#define MDDR_DDRC_DRAM_BANK_ACT_TIMING_CR 0x130
#define MDDR_DDRC_ODT_PARAM_1_CR 0x14
#define MDDR_DDRC_ODT_PARAM_2_CR 0x10
#define MDDR_DDRC_DEBUG_CR 0x3300
#define MDDR_DDRC_MODE_REG_RD_WR_CR 0x0
#define MDDR_DDRC_MODE_REG_DATA_CR 0x0
#define MDDR_DDRC_PWR_SAVE_1_CR 0x40c
#define MDDR_DDRC_PWR_SAVE_2_CR 0x0
#define MDDR_DDRC_ZQ_LONG_TIME_CR 0x0
#define MDDR_DDRC_ZQ_SHORT_TIME_CR 0x0
#define MDDR_DDRC_ZQ_SHORT_INT_REFRESH_MARGIN_1_CR 0x2
#define MDDR_DDRC_ZQ_SHORT_INT_REFRESH_MARGIN_2_CR 0x0
#define MDDR_DDRC_PERF_PARAM_1_CR 0x2080
#define MDDR_DDRC_HPR_QUEUE_PARAM_1_CR 0x80f8
#define MDDR_DDRC_HPR_QUEUE_PARAM_2_CR 0x7
#define MDDR_DDRC_LPR_QUEUE_PARAM_1_CR 0x80f8
#define MDDR_DDRC_LPR_QUEUE_PARAM_2_CR 0x7
#define MDDR_DDRC_WR_QUEUE_PARAM_CR 0x200
#define MDDR_DDRC_PERF_PARAM_2_CR 0x0
#define MDDR_DDRC_PERF_PARAM_3_CR 0x0
#define MDDR_DDRC_DFI_RDDATA_EN_CR 0x3
#define MDDR_DDRC_DFI_MIN_CTRLUPD_TIMING_CR 0x3
#define MDDR_DDRC_DFI_MAX_CTRLUPD_TIMING_CR 0x40
#define MDDR_DDRC_DFI_WR_LVL_CONTROL_1_CR 0x0
#define MDDR_DDRC_DFI_WR_LVL_CONTROL_2_CR 0x0
#define MDDR_DDRC_DFI_RD_LVL_CONTROL_1_CR 0x0
#define MDDR_DDRC_DFI_RD_LVL_CONTROL_2_CR 0x0
#define MDDR_DDRC_DFI_CTRLUPD_TIME_INTERVAL_CR 0x309
#define MDDR_DDRC_DYN_SOFT_RESET_ALIAS_CR 0x1
#define MDDR_DDRC_AXI_FABRIC_PRI_ID_CR 0x0
#define MDDR_DDRC_SR 0x0
#define MDDR_DDRC_SINGLE_ERR_CNT_SR 0x0
#define MDDR_DDRC_DOUBLE_ERR_CNT_SR 0x0
#define MDDR_DDRC_LUE_SYNDROME_1_SR 0x0
#define MDDR_DDRC_LUE_SYNDROME_2_SR 0x0
#define MDDR_DDRC_LUE_SYNDROME_3_SR 0x0
#define MDDR_DDRC_LUE_SYNDROME_4_SR 0x0
#define MDDR_DDRC_LUE_SYNDROME_5_SR 0x0
#define MDDR_DDRC_LUE_ADDRESS_1_SR 0x0
#define MDDR_DDRC_LUE_ADDRESS_2_SR 0x0
#define MDDR_DDRC_LCE_SYNDROME_1_SR 0x0
#define MDDR_DDRC_LCE_SYNDROME_2_SR 0x0
#define MDDR_DDRC_LCE_SYNDROME_3_SR 0x0
#define MDDR_DDRC_LCE_SYNDROME_4_SR 0x0
#define MDDR_DDRC_LCE_SYNDROME_5_SR 0x0
#define MDDR_DDRC_LCE_ADDRESS_1_SR 0x0
#define MDDR_DDRC_LCE_ADDRESS_2_SR 0x0
#define MDDR_DDRC_LCB_NUMBER_SR 0x0
#define MDDR_DDRC_LCB_MASK_1_SR 0x0
#define MDDR_DDRC_LCB_MASK_2_SR 0x0
#define MDDR_DDRC_LCB_MASK_3_SR 0x0
#define MDDR_DDRC_LCB_MASK_4_SR 0x0
#define MDDR_DDRC_ECC_INT_SR 0x0
#define MDDR_DDRC_ECC_INT_CLR_REG 0x0
#define MDDR_DDRC_ECC_OUTPUT_DATA_SR 0x0
#define MDDR_PHY_DYN_BIST_TEST_CR 0x0
#define MDDR_PHY_DYN_BIST_TEST_ERRCLR_1_CR 0x0
#define MDDR_PHY_DYN_BIST_TEST_ERRCLR_2_CR 0x0
#define MDDR_PHY_DYN_BIST_TEST_ERRCLR_3_CR 0x0
#define MDDR_PHY_BIST_TEST_SHIFT_PATTERN_1_CR 0x0
#define MDDR_PHY_BIST_TEST_SHIFT_PATTERN_2_CR 0x0
#define MDDR_PHY_BIST_TEST_SHIFT_PATTERN_3_CR 0x0
#define MDDR_PHY_LOOPBACK_TEST_CR 0x0
#define MDDR_PHY_BOARD_LOOPBACK_CR 0x0
#define MDDR_PHY_CTRL_SLAVE_RATIO_CR 0x80
#define MDDR_PHY_CTRL_SLAVE_FORCE_CR 0x0
#define MDDR_PHY_CTRL_SLAVE_DELAY_CR 0x0
#define MDDR_PHY_DATA_SLICE_IN_USE_CR 0x3
#define MDDR_PHY_LVL_NUM_OF_DQ0_CR 0x0
#define MDDR_PHY_DQ_OFFSET_1_CR 0x0
#define MDDR_PHY_DQ_OFFSET_2_CR 0x0
#define MDDR_PHY_DQ_OFFSET_3_CR 0x0
#define MDDR_PHY_DIS_CALIB_RST_CR 0x0
#define MDDR_PHY_DLL_LOCK_DIFF_CR 0xb
#define MDDR_PHY_FIFO_WE_IN_DELAY_1_CR 0x0
#define MDDR_PHY_FIFO_WE_IN_DELAY_2_CR 0x0
#define MDDR_PHY_FIFO_WE_IN_DELAY_3_CR 0x0
#define MDDR_PHY_FIFO_WE_IN_FORCE_CR 0x0
#define MDDR_PHY_FIFO_WE_SLAVE_RATIO_1_CR 0x40
#define MDDR_PHY_FIFO_WE_SLAVE_RATIO_2_CR 0x401
#define MDDR_PHY_FIFO_WE_SLAVE_RATIO_3_CR 0x4010
#define MDDR_PHY_FIFO_WE_SLAVE_RATIO_4_CR 0x0
#define MDDR_PHY_GATELVL_INIT_MODE_CR 0x0
#define MDDR_PHY_GATELVL_INIT_RATIO_1_CR 0x0
#define MDDR_PHY_GATELVL_INIT_RATIO_2_CR 0x0
#define MDDR_PHY_GATELVL_INIT_RATIO_3_CR 0x0
#define MDDR_PHY_GATELVL_INIT_RATIO_4_CR 0x0
#define MDDR_PHY_LOCAL_ODT_CR 0x0
#define MDDR_PHY_INVERT_CLKOUT_CR 0x0
#define MDDR_PHY_RD_DQS_SLAVE_DELAY_1_CR 0x0
#define MDDR_PHY_RD_DQS_SLAVE_DELAY_2_CR 0x0
#define MDDR_PHY_RD_DQS_SLAVE_DELAY_3_CR 0x0
#define MDDR_PHY_RD_DQS_SLAVE_FORCE_CR 0x0
#define MDDR_PHY_RD_DQS_SLAVE_RATIO_1_CR 0x40
#define MDDR_PHY_RD_DQS_SLAVE_RATIO_2_CR 0x401
#define MDDR_PHY_RD_DQS_SLAVE_RATIO_3_CR 0x4010
#define MDDR_PHY_RD_DQS_SLAVE_RATIO_4_CR 0x0
#define MDDR_PHY_WR_DQS_SLAVE_DELAY_1_CR 0x0
#define MDDR_PHY_WR_DQS_SLAVE_DELAY_2_CR 0x0
#define MDDR_PHY_WR_DQS_SLAVE_DELAY_3_CR 0x0
#define MDDR_PHY_WR_DQS_SLAVE_FORCE_CR 0x0
#define MDDR_PHY_WR_DQS_SLAVE_RATIO_1_CR 0x0
#define MDDR_PHY_WR_DQS_SLAVE_RATIO_2_CR 0x0
#define MDDR_PHY_WR_DQS_SLAVE_RATIO_3_CR 0x0
#define MDDR_PHY_WR_DQS_SLAVE_RATIO_4_CR 0x0
#define MDDR_PHY_WR_DATA_SLAVE_DELAY_1_CR 0x0
#define MDDR_PHY_WR_DATA_SLAVE_DELAY_2_CR 0x0
#define MDDR_PHY_WR_DATA_SLAVE_DELAY_3_CR 0x0
#define MDDR_PHY_WR_DATA_SLAVE_FORCE_CR 0x0
#define MDDR_PHY_WR_DATA_SLAVE_RATIO_1_CR 0x40
#define MDDR_PHY_WR_DATA_SLAVE_RATIO_2_CR 0x401
#define MDDR_PHY_WR_DATA_SLAVE_RATIO_3_CR 0x4010
#define MDDR_PHY_WR_DATA_SLAVE_RATIO_4_CR 0x0
#define MDDR_PHY_WRLVL_INIT_MODE_CR 0x0
#define MDDR_PHY_WRLVL_INIT_RATIO_1_CR 0x0
#define MDDR_PHY_WRLVL_INIT_RATIO_2_CR 0x0
#define MDDR_PHY_WRLVL_INIT_RATIO_3_CR 0x0
#define MDDR_PHY_WRLVL_INIT_RATIO_4_CR 0x0
#define MDDR_PHY_WR_RD_RL_CR 0x21
#define MDDR_PHY_RDC_FIFO_RST_ERR_CNT_CLR_CR 0x0
#define MDDR_PHY_RDC_WE_TO_RE_DELAY_CR 0x3
#define MDDR_PHY_USE_FIXED_RE_CR 0x1
#define MDDR_PHY_USE_RANK0_DELAYS_CR 0x1
#define MDDR_PHY_USE_LVL_TRNG_LEVEL_CR 0x0
#define MDDR_PHY_DYN_CONFIG_CR 0x9
#define MDDR_PHY_RD_WR_GATE_LVL_CR 0x0
#define MDDR_PHY_DYN_RESET_CR 0x1
#define MDDR_PHY_LEVELLING_FAILURE_SR 0x0
#define MDDR_PHY_BIST_ERROR_1_SR 0x0
#define MDDR_PHY_BIST_ERROR_2_SR 0x0
#define MDDR_PHY_BIST_ERROR_3_SR 0x0
#define MDDR_PHY_WRLVL_DQS_RATIO_1_SR 0x0
#define MDDR_PHY_WRLVL_DQS_RATIO_2_SR 0x0
#define MDDR_PHY_WRLVL_DQS_RATIO_3_SR 0x0
#define MDDR_PHY_WRLVL_DQS_RATIO_4_SR 0x0
#define MDDR_PHY_WRLVL_DQ_RATIO_1_SR 0x0
#define MDDR_PHY_WRLVL_DQ_RATIO_2_SR 0x0
#define MDDR_PHY_WRLVL_DQ_RATIO_3_SR 0x0
#define MDDR_PHY_WRLVL_DQ_RATIO_4_SR 0x0
#define MDDR_PHY_RDLVL_DQS_RATIO_1_SR 0x0
#define MDDR_PHY_RDLVL_DQS_RATIO_2_SR 0x0
#define MDDR_PHY_RDLVL_DQS_RATIO_3_SR 0x0
#define MDDR_PHY_RDLVL_DQS_RATIO_4_SR 0x0
#define MDDR_PHY_FIFO_1_SR 0x0
#define MDDR_PHY_FIFO_2_SR 0x0
#define MDDR_PHY_FIFO_3_SR 0x0
#define MDDR_PHY_FIFO_4_SR 0x0
#define MDDR_PHY_MASTER_DLL_SR 0x0
#define MDDR_PHY_DLL_SLAVE_VALUE_1_SR 0x0
#define MDDR_PHY_DLL_SLAVE_VALUE_2_SR 0x0
#define MDDR_PHY_STATUS_OF_IN_DELAY_VAL_1_SR 0x0
#define MDDR_PHY_STATUS_OF_IN_DELAY_VAL_2_SR 0x0
#define MDDR_PHY_STATUS_OF_OUT_DELAY_VAL_1_SR 0x0
#define MDDR_PHY_STATUS_OF_OUT_DELAY_VAL_2_SR 0x0
#define MDDR_PHY_DLL_LOCK_AND_SLAVE_VAL_SR 0x0
#define MDDR_PHY_CTRL_OUTPUT_FILTER_SR 0x0
#define MDDR_PHY_CTRL_OF_OUTPUT_DELAY_SR 0x0
#define MDDR_PHY_RD_DQS_SLAVE_DLL_VAL_1_SR 0x0
#define MDDR_PHY_RD_DQS_SLAVE_DLL_VAL_2_SR 0x0
#define MDDR_PHY_RD_DQS_SLAVE_DLL_VAL_3_SR 0x0
#define MDDR_PHY_WR_DATA_SLAVE_DLL_VAL_1_SR 0x0
#define MDDR_PHY_WR_DATA_SLAVE_DLL_VAL_2_SR 0x0
#define MDDR_PHY_WR_DATA_SLAVE_DLL_VAL_3_SR 0x0
#define MDDR_PHY_FIFO_WE_SLAVE_DLL_VAL_1_SR 0x0
#define MDDR_PHY_FIFO_WE_SLAVE_DLL_VAL_2_SR 0x0
#define MDDR_PHY_FIFO_WE_SLAVE_DLL_VAL_3_SR 0x0
#define MDDR_PHY_WR_DQS_SLAVE_DLL_VAL_1_SR 0x0
#define MDDR_PHY_WR_DQS_SLAVE_DLL_VAL_2_SR 0x0
#define MDDR_PHY_WR_DQS_SLAVE_DLL_VAL_3_SR 0x0
#define MDDR_PHY_CTRL_SLAVE_DLL_VAL_SR 0x0
#define MDDR_DDR_FIC_NB_ADDR_CR 0x0
#define MDDR_DDR_FIC_NBRWB_SIZE_CR 0x0
#define MDDR_DDR_FIC_WB_TIMEOUT_CR 0x0
#define MDDR_DDR_FIC_HPD_SW_RW_EN_CR 0x0
#define MDDR_DDR_FIC_HPD_SW_RW_INVAL_CR 0x0
#define MDDR_DDR_FIC_SW_WR_ERCLR_CR 0x0
#define MDDR_DDR_FIC_ERR_INT_ENABLE_CR 0x0
#define MDDR_DDR_FIC_NUM_AHB_MASTERS_CR 0x0
#define MDDR_DDR_FIC_HPB_ERR_ADDR_1_SR 0x0
#define MDDR_DDR_FIC_HPB_ERR_ADDR_2_SR 0x0
#define MDDR_DDR_FIC_SW_ERR_ADDR_1_SR 0x0
#define MDDR_DDR_FIC_SW_ERR_ADDR_2_SR 0x0
#define MDDR_DDR_FIC_HPD_SW_WRB_EMPTY_SR 0x0
#define MDDR_DDR_FIC_SW_HPB_LOCKOUT_SR 0x0
#define MDDR_DDR_FIC_SW_HPD_WERR_SR 0x0
#define MDDR_DDR_FIC_LOCK_TIMEOUTVAL_1_CR 0x0
#define MDDR_DDR_FIC_LOCK_TIMEOUTVAL_2_CR 0x0
#define MDDR_DDR_FIC_LOCK_TIMEOUT_EN_CR 0x0
#define MDDR_DDR_FIC_RDWR_ERR_SR 0x0

