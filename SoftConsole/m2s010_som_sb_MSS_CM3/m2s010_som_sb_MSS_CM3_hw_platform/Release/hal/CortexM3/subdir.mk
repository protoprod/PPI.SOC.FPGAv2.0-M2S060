################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../hal/CortexM3/cortex_nvic.c 

OBJS += \
./hal/CortexM3/cortex_nvic.o 

C_DEPS += \
./hal/CortexM3/cortex_nvic.d 


# Each subdirectory must supply rules for building sources it contributes
hal/CortexM3/%.o: ../hal/CortexM3/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: GNU C Compiler'
	arm-none-eabi-gcc -mthumb -mcpu=cortex-m3 -DNDEBUG -IC:\PULSAR\Projects\PPI\PoweredRail\Common_Module_SOC\CommonModule_Rev1_5_Unified\SoftConsole\m2s010_som_sb_MSS_CM3\m2s010_som_sb_MSS_CM3_hw_platform -IC:\PULSAR\Projects\PPI\PoweredRail\Common_Module_SOC\CommonModule_Rev1_5_Unified\SoftConsole\m2s010_som_sb_MSS_CM3\m2s010_som_sb_MSS_CM3_hw_platform\CMSIS -IC:\PULSAR\Projects\PPI\PoweredRail\Common_Module_SOC\CommonModule_Rev1_5_Unified\SoftConsole\m2s010_som_sb_MSS_CM3\m2s010_som_sb_MSS_CM3_hw_platform\CMSIS\startup_gcc -IC:\PULSAR\Projects\PPI\PoweredRail\Common_Module_SOC\CommonModule_Rev1_5_Unified\SoftConsole\m2s010_som_sb_MSS_CM3\m2s010_som_sb_MSS_CM3_hw_platform\drivers -IC:\PULSAR\Projects\PPI\PoweredRail\Common_Module_SOC\CommonModule_Rev1_5_Unified\SoftConsole\m2s010_som_sb_MSS_CM3\m2s010_som_sb_MSS_CM3_hw_platform\drivers\mss_ethernet_mac -IC:\PULSAR\Projects\PPI\PoweredRail\Common_Module_SOC\CommonModule_Rev1_5_Unified\SoftConsole\m2s010_som_sb_MSS_CM3\m2s010_som_sb_MSS_CM3_hw_platform\drivers\mss_gpio -IC:\PULSAR\Projects\PPI\PoweredRail\Common_Module_SOC\CommonModule_Rev1_5_Unified\SoftConsole\m2s010_som_sb_MSS_CM3\m2s010_som_sb_MSS_CM3_hw_platform\drivers\mss_hpdma -IC:\PULSAR\Projects\PPI\PoweredRail\Common_Module_SOC\CommonModule_Rev1_5_Unified\SoftConsole\m2s010_som_sb_MSS_CM3\m2s010_som_sb_MSS_CM3_hw_platform\drivers\mss_i2c -IC:\PULSAR\Projects\PPI\PoweredRail\Common_Module_SOC\CommonModule_Rev1_5_Unified\SoftConsole\m2s010_som_sb_MSS_CM3\m2s010_som_sb_MSS_CM3_hw_platform\drivers\mss_nvm -IC:\PULSAR\Projects\PPI\PoweredRail\Common_Module_SOC\CommonModule_Rev1_5_Unified\SoftConsole\m2s010_som_sb_MSS_CM3\m2s010_som_sb_MSS_CM3_hw_platform\drivers\mss_rtc -IC:\PULSAR\Projects\PPI\PoweredRail\Common_Module_SOC\CommonModule_Rev1_5_Unified\SoftConsole\m2s010_som_sb_MSS_CM3\m2s010_som_sb_MSS_CM3_hw_platform\drivers\mss_spi -IC:\PULSAR\Projects\PPI\PoweredRail\Common_Module_SOC\CommonModule_Rev1_5_Unified\SoftConsole\m2s010_som_sb_MSS_CM3\m2s010_som_sb_MSS_CM3_hw_platform\drivers\mss_sys_services -IC:\PULSAR\Projects\PPI\PoweredRail\Common_Module_SOC\CommonModule_Rev1_5_Unified\SoftConsole\m2s010_som_sb_MSS_CM3\m2s010_som_sb_MSS_CM3_hw_platform\drivers\mss_timer -IC:\PULSAR\Projects\PPI\PoweredRail\Common_Module_SOC\CommonModule_Rev1_5_Unified\SoftConsole\m2s010_som_sb_MSS_CM3\m2s010_som_sb_MSS_CM3_hw_platform\drivers\mss_uart -IC:\PULSAR\Projects\PPI\PoweredRail\Common_Module_SOC\CommonModule_Rev1_5_Unified\SoftConsole\m2s010_som_sb_MSS_CM3\m2s010_som_sb_MSS_CM3_hw_platform\drivers\mss_usb -IC:\PULSAR\Projects\PPI\PoweredRail\Common_Module_SOC\CommonModule_Rev1_5_Unified\SoftConsole\m2s010_som_sb_MSS_CM3\m2s010_som_sb_MSS_CM3_hw_platform\drivers_config -IC:\PULSAR\Projects\PPI\PoweredRail\Common_Module_SOC\CommonModule_Rev1_5_Unified\SoftConsole\m2s010_som_sb_MSS_CM3\m2s010_som_sb_MSS_CM3_hw_platform\drivers_config\sys_config -IC:\PULSAR\Projects\PPI\PoweredRail\Common_Module_SOC\CommonModule_Rev1_5_Unified\SoftConsole\m2s010_som_sb_MSS_CM3\m2s010_som_sb_MSS_CM3_hw_platform\hal -IC:\PULSAR\Projects\PPI\PoweredRail\Common_Module_SOC\CommonModule_Rev1_5_Unified\SoftConsole\m2s010_som_sb_MSS_CM3\m2s010_som_sb_MSS_CM3_hw_platform\hal\CortexM3 -IC:\PULSAR\Projects\PPI\PoweredRail\Common_Module_SOC\CommonModule_Rev1_5_Unified\SoftConsole\m2s010_som_sb_MSS_CM3\m2s010_som_sb_MSS_CM3_hw_platform\hal\CortexM3\GNU -O2 -ffunction-sections -fdata-sections -g -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o"$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


