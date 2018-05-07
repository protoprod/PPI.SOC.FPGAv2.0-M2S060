----------------------------------------------------------------------------------
-- Company:         Bluefin Innovations LLC
-- Create Date:     5 December 2-017
-- Module Name:     mdio_slave_interface.vhd 
-- Project Name:    Powered Rail Performance Tester
-- Target Devices:  TBD
-- Description:     
--    The Bluefin Innovations FPGA Fabric supports both the transmission and 
--    reception of packets and resides between the AFE and processor MAC.
--
-- Structure:
--    CommsFPGA_top.vhd                 
--
-- Revision:  0.1
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
--
entity mdio_slave_interface is
   port (
      PMAD_rst_in	        : in std_logic;		-- active high
      PMAD_clk              : in std_logic;
	  PMAD_link_status      : in std_logic;		-- PMA/PMD receive link up
	  PMAD_fault_status     : in std_logic;		-- PMA/PMD fault condition detected active high
	  PMAD_jabber_det	    : in std_logic;		-- PMA/PMD jabber detect active high
      PMAD_mdo              : out std_logic;
      PMAD_mdi              : in std_logic;
      PMAD_mdo_en           : out std_logic;
	  PMAD_rst_out			: out std_logic;	-- active high
	  PMAD_loopbk_en		: out std_logic;	-- active high	
	  PMAD_lowpwr_en		: out std_logic;	-- active high	
	  PMAD_isolate_en		: out std_logic;	-- isolate Phy from MII active high
	  PMAD_COL_test			: out std_logic		-- test PHY signal active high
      );
end entity mdio_slave_interface;
--
architecture translated of mdio_slave_interface is

   constant xhdl_timescale         : time := 1 ns;
   
   --////////////////////////////////////////////////////////////////////
   --
   -- PHY management (MIIM) Supported Register definitions
   --
   -- Addr | Register Name
   ----------------------------------------------------------------------
   --   0  | Control reg.     |--> control register,basic register,read and write register
   --   1  | Status reg. 1    |--> normal operation,basic register,read_only register
   --   2  | PHY ID reg. 1    |--> PHY ID register,read_only regisetr
   --   3  | PHY ID reg. 2    |--> PHY ID register,read_only regisetr
   --   4  | Register4	      |--> r/w for testing and future
   --   5  | Register5	      |--> r/w for testing and future 
   --   6  | Register6		  |--> r/w for testing and future
   --	7  | Register7	      |--> r/w for testing and future		
   -- 	8  | Register8	      |--> r/w for testing and future		
   --   9  | Register9	      |--> r/w for testing and future		
   --	10 | Register10	      |--> r/w for testing and future		
   --	11 | Register11	      |--> r/w for testing and future		
   --	12 | Register12	      |--> r/w for testing and future		
   --	13 | Register13	      |--> r/w for testing and future		
   --	14 | Register14	      |--> r/w for testing and future		
   --	15 | Register15	      |--> r/w for testing and future
   ----------------------------------------------------------------------

   -- Status register
   signal status_bit15_9           :  std_logic_vector(15 downto 9);
   signal status_bit8              :  std_logic;   
   signal status_bit6_0            :  std_logic_vector(6 downto 0) := "0000000";
   -- PHY ID register 1
   signal phy_id1                  :  std_logic_vector(15 downto 0) := x"0022";	--"0000000000010011";
   -- PHY ID register 2
   signal phy_id2                  :  std_logic_vector(15 downto 0) := x"1556";	--"011110" & "001110" & "0010";
   signal phy_addr                 :  std_logic_vector(4 downto 0) := "00000";		-- set address = debug phy address
   ---------------------------
   signal Register0                :  std_logic_vector(15 downto 0);
   signal Register1                :  std_logic_vector(15 downto 0);
   signal Register2                :  std_logic_vector(15 downto 0);
   signal Register3                :  std_logic_vector(15 downto 0);
   signal Register4                :  std_logic_vector(15 downto 0);
   signal Register5                :  std_logic_vector(15 downto 0);
   signal Register6                :  std_logic_vector(15 downto 0);
   signal Register7                :  std_logic_vector(15 downto 0);
   signal Register8                :  std_logic_vector(15 downto 0);
   signal Register9                :  std_logic_vector(15 downto 0);
   signal Register10               :  std_logic_vector(15 downto 0);
   signal Register11               :  std_logic_vector(15 downto 0);
   signal Register12               :  std_logic_vector(15 downto 0);
   signal Register13               :  std_logic_vector(15 downto 0);
   signal Register14               :  std_logic_vector(15 downto 0);
   signal Register15               :  std_logic_vector(15 downto 0);
   signal Register16               :  std_logic_vector(15 downto 0);
   signal Register17               :  std_logic_vector(15 downto 0);
   --------------------------
   
-- MDIO Slave state machine state defintions
type   MDIO_Slave_STATE_TYPE is (
              SM_ST_0, SM_ST_1, SM_OP_0, SM_OP_1, SM_PHY_ADD,
              SM_REG_ADD,SM_TA_0,SM_TA_1,SM_DATA);
signal slave_state	: MDIO_Slave_STATE_TYPE; 

   --//////////////////////////////////////////////////////////////////////
   signal mdio_output              :  std_logic;
   signal mdio_output_enable       :  std_logic;
   signal mdio_reg                 :  std_logic;
   signal phy_address              :  std_logic_vector(4 downto 0);
   signal reg_address              :  std_logic_vector(4 downto 0);
   signal reg_data_in              :  std_logic_vector(15 downto 0);
   signal reg_data_out             :  std_logic_vector(15 downto 0);
   signal register_bus_out         :  std_logic_vector(15 downto 0);
   signal register_bus_in          :  std_logic_vector(15 downto 0);
   signal md_transfer_cnt          :  std_logic_vector(6 downto 0);
   signal md_transfer_cnt_reset    :  std_logic;
   signal mdio_rd_wr               :  std_logic;
   signal respond_to_all_phy_addr  :  std_logic;
   signal md_put_reg_data_out      :  std_logic;
   signal md_get_phy_address       :  std_logic;
   signal md_get_reg_address       :  std_logic;
   signal md_get_reg_data_in       :  std_logic;
   signal md_put_reg_data_in       :  std_logic;
   --
   signal count                    :  std_logic_vector(4 downto 0);
   --
   signal PMAD_rst_reg			:  std_logic;
   signal PMAD_link_status_d	:  std_logic;
   signal PMAD_fault_status_d	:  std_logic;
   signal PMAD_jabber_det_d		:  std_logic;
   signal status_regClear_d		:  std_logic_vector(2 downto 0);	
   signal status_reg_addr		:  std_logic;
  
begin
	-- Status Register
	Register1 <=  "0"			-- 1.15 100BASE-T4 capable active high
				& "0"			-- 1.14 100BASE-X full duplex capable active high
				& "0"			-- 1.13 100BASE-X half duplex capable active high
				& "0"			-- 1.12 10Mb/s full duplex capable active high
				& "1"			-- 1.11 10Mb/s half duplex capable active high
				& "0000"		-- 1.10:7 Reserved
				& "0"			-- 1.6  MF Preamble Suppression capable active high
				& "0"			-- 1.5  Auto-Negotiation Complete active high (not capable)
				& "0"  			--PMAD_fault_status_d	-- 1.4  Remote fault active high
				& "0"			-- 1.3  Auto-Negotiation ability active high
				& "1"			--PMAD_link_status_d	-- 1.2  Auto-Negotiation ability active high
				& "0"   		--PMAD_jabber_det_d		-- 1.1  jabber detect active high	
				& "1";			-- 1.0  extended register capability	
	
	Register2 <= phy_id1;
	Register3 <= phy_id2;

	PMAD_mdo <= mdio_output;
	PMAD_mdo_en <= mdio_output_enable;
	
	PMAD_rst_out 	<= Register0(15);	-- reset out is 1 cycle of the MDIO Clock, active high
	PMAD_loopbk_en	<= Register0(14);	-- PMA loopback active high
	PMAD_lowpwr_en  <= Register0(11);	-- low power mode active high
	PMAD_isolate_en <= Register0(10);	-- Electrically isolate Phy from MII
	PMAD_COL_test 	<= Register0(7);	-- test COL signal active high
	
	status_reg_addr <= '1' when ((reg_address = "00001") and (slave_state = SM_DATA)) else '0';

--------------------------------------------------------------------------------
-- Reset in processing: Can’t guarantee MDC when reset comes in so must be async
---------1---------2---------3---------4---------5---------6---------7---------8 
	process (PMAD_clk,PMAD_rst_reg)
	begin
	  if (PMAD_rst_in = '1') then		
	    PMAD_rst_reg <= '1';
      elsif (PMAD_clk'EVENT AND PMAD_clk = '1') then
		PMAD_rst_reg <= PMAD_rst_out;		--Register0(15) combine all PMAD resets here
      end if;
	end process;
	
--------------------------------------------------------------------------------
-- Remote fault is phy specific.  It is set on the fault and cleared when Status Register0 is read or phy reset
---------1---------2---------3---------4---------5---------6---------7---------8 
	process (PMAD_fault_status, PMAD_rst_reg, status_regClear_d(2))
	begin
      if (PMAD_fault_status'EVENT AND PMAD_fault_status = '1') then
    	PMAD_fault_status_d <= '1';		-- set on fault
	  elsif (PMAD_rst_reg'EVENT AND PMAD_rst_reg = '1') then
    	PMAD_fault_status_d <= '0';		-- reset on register on Phy reset
	  elsif (status_regClear_d(2)'EVENT AND status_regClear_d(2) = '1') then
    	PMAD_fault_status_d <= '0';		-- reset when status register is read
      end if;
	end process;
	
--------------------------------------------------------------------------------
-- jabber detect is phy specific.  It is set on the fault and cleared when Status Register0 is read or phy reset
---------1---------2---------3---------4---------5---------6---------7---------8 
	process (PMAD_jabber_det, PMAD_rst_reg, status_regClear_d(2))
	begin
      if (PMAD_jabber_det'EVENT AND PMAD_jabber_det = '1') then
    	PMAD_jabber_det_d <= '1';		-- set on jabber
	  elsif (PMAD_rst_reg'EVENT AND PMAD_rst_reg = '1') then
    	PMAD_jabber_det_d <= '0';		-- reset on register on Phy reset
	  elsif (status_regClear_d(2)'EVENT AND status_regClear_d(2) = '1') then
    	PMAD_jabber_det_d <= '0';		-- reset when status register is read
      end if;
	end process;
	
--------------------------------------------------------------------------------
-- Link Status is Phy specific.  It is reset on link = 0 and set on status read or phy reset
---------1---------2---------3---------4---------5---------6---------7---------8 
	process (PMAD_link_status, PMAD_rst_reg, status_regClear_d(2))
	begin
      if (PMAD_link_status'EVENT AND PMAD_link_status = '0') then
    	PMAD_link_status_d <= '0';		-- reset on Link Bit inactive
	  elsif (PMAD_rst_reg'EVENT AND PMAD_rst_reg = '1') then
    	PMAD_link_status_d <= '1';		-- set on register on Phy reset
	  elsif (status_regClear_d(2)'EVENT AND status_regClear_d(2) = '1') then
    	PMAD_link_status_d <= '1';		-- set when status register is read
      end if;
	end process;
	
--------------------------------------------------------------------------------
-- Registered MDIO output and miscellaneous registers
---------1---------2---------3---------4---------5---------6---------7---------8 
   process (PMAD_clk,PMAD_rst_reg)
   begin
      if (PMAD_rst_reg = '1') THEN
        mdio_reg <= '0' ;
		status_regClear_d(2 downto 0) <= "000";
      elsif (PMAD_clk'EVENT AND PMAD_clk = '1') THEN
        mdio_reg <= PMAD_mdi;
		status_regClear_d(0) <= mdio_rd_wr and status_reg_addr;
		status_regClear_d(1) <= status_regClear_d(0);
		status_regClear_d(2) <= status_regClear_d(1) and (not status_regClear_d(0)); -- falling edge
      end if;
   end process;
   
--------------------------------------------------------------------------------
-- Registered MDIO output
---------1---------2---------3---------4---------5---------6---------7---------8 

   process (PMAD_clk,PMAD_rst_reg)
   begin
        if (PMAD_rst_reg = '1') THEN		-- async reset since can't gurantee a clock
            phy_address <= "00000";
            reg_address <= "00000";
            reg_data_in <= "0000000000000000";
            reg_data_out <= "0000000000000000";
            count <= "10000"; 
		elsif (PMAD_clk'EVENT AND PMAD_clk = '1') THEN
            if (md_get_phy_address = '1') THEN
               phy_address(4 downto 1) <= phy_address(3 downto 0);
               phy_address(0) <= mdio_reg;
            end if;

            if (md_get_reg_address = '1') THEN
               reg_address(4 downto 1) <= reg_address(3 downto 0);
               reg_address(0) <= mdio_reg;
            end if;

            if (md_get_reg_data_in = '1') THEN
               reg_data_in(15 downto 1) <= reg_data_in(14 downto 0);
               reg_data_in(0) <= mdio_reg;
            end if;

            if (mdio_output_enable = '1') THEN
               count <= count - "00001";
            else
               count <= "10000";
            end if;
        end if;
   end process;
   --
   register_bus_in <= reg_data_in  ;
   
--------------------------------------------------------------------------------
-- Transfer Count SM
---------1---------2---------3---------4---------5---------6---------7---------8 

   process (PMAD_clk,PMAD_rst_reg)
   begin
	  if (PMAD_rst_reg = '1') THEN
            md_transfer_cnt <= "0100001";
      elsif (PMAD_clk'EVENT AND PMAD_clk = '1') THEN
        if (md_transfer_cnt_reset = '1') THEN
          md_transfer_cnt <= "0100001";
        elsif (md_transfer_cnt < "1000000") THEN
          md_transfer_cnt <= md_transfer_cnt + "0000001";
        else
          md_transfer_cnt <= "0100001";
        end if;
      end if;
   end process;

--------------------------------------------------------------------------------
-- Main State Machine
---------1---------2---------3---------4---------5---------6---------7---------8 

   process (PMAD_clk,PMAD_rst_reg)
   begin
      if (PMAD_rst_reg = '1') THEN		-- async reset since can't gurantee a clock
	    respond_to_all_phy_addr <= '0';
        mdio_output_enable <= '0';
        md_transfer_cnt_reset <= '1';
        md_get_phy_address <= '0';
        md_get_reg_address <= '0';
        md_put_reg_data_out <= '0';
        md_get_reg_data_in <= '0';
        md_put_reg_data_in <= '0';
        mdio_rd_wr <= '0';
        slave_state <= SM_ST_0;
      elsif (PMAD_clk'EVENT AND PMAD_clk = '1') THEN
        CASE slave_state is
        --
          when SM_ST_0 =>
                        md_put_reg_data_in <= '0';
						mdio_output_enable <= '0';
                        if (mdio_reg /= '0') THEN
                           md_transfer_cnt_reset <= '1';
                        else
                           md_transfer_cnt_reset <= '0';
                           slave_state <= SM_ST_1;
                        end if;
               --

          when SM_ST_1 =>
                        if (mdio_reg /= '1') THEN
                           md_transfer_cnt_reset <= '1';
                           slave_state <= SM_ST_0;
                        else
                           md_transfer_cnt_reset <= '0';
                           slave_state <= SM_OP_0;
                        end if;
               --

          when SM_OP_0 =>
                        slave_state <= SM_OP_1;
                        if (mdio_reg = '1') THEN
                           mdio_rd_wr <= '1';
                        else
                           mdio_rd_wr <= '0';
                        end if;
               --

          when SM_OP_1 =>
                        md_get_phy_address <= '1';
                        if ((mdio_reg = '0') AND (mdio_rd_wr = '1')) THEN
                           mdio_rd_wr <= '1';
                           slave_state <= SM_PHY_ADD;
                        ELSIF ((mdio_reg = '1') AND (mdio_rd_wr = '0')) THEN
                              mdio_rd_wr <= '0';
                              slave_state <= SM_PHY_ADD;
                        else
                              md_transfer_cnt_reset <= '1';
                              slave_state <= SM_ST_0;
                        end if;
               --

          when SM_PHY_ADD =>
                        --

                        if (md_transfer_cnt = "0101000") THEN
                           md_get_phy_address <= '0';
                           md_get_reg_address <= '1';
                           --md_put_reg_data_out 		<= 1'b1;
                           slave_state <= SM_REG_ADD;
						   if (mdio_rd_wr = '1') THEN
							 md_put_reg_data_out <= '1';
                           else
                           end if;
                        else   
                        end if;
               --

          when SM_REG_ADD =>
                        --

                        if (md_transfer_cnt = "0101101") THEN
                           md_get_reg_address <= '0';
                           slave_state <= SM_TA_0;
                           if (mdio_rd_wr = '1') THEN
                              mdio_output_enable <= '0';
                           else

                           end if;
                        else

                        end if;
               --

          when SM_TA_0 =>
                        md_put_reg_data_out <= '0';
                        if (mdio_rd_wr = '1') THEN
                           --read
                           if (phy_address = phy_addr) THEN
                              mdio_output_enable <= '1';
                              slave_state <= SM_TA_1;
                           else
                              mdio_output_enable <= '0';
                              slave_state <= SM_ST_0;
                           end if;
                        else
                           -- write
                           mdio_output_enable <= '0';
                           if (mdio_reg /= '1') THEN
                              md_transfer_cnt_reset <= '1';
                              slave_state <= SM_ST_0;
                           else
                              md_transfer_cnt_reset <= '0';
                              slave_state <= SM_TA_1;
                           end if;
                        end if;
               --

          when SM_TA_1 =>
                        if (mdio_rd_wr = '0') THEN
                           md_get_reg_data_in <= '1';
                           if (mdio_reg /= '0') THEN
                              md_transfer_cnt_reset <= '1';
                              slave_state <= SM_ST_0;
                           else
                              slave_state <= SM_DATA;
                           end if;
                        else
                           md_get_reg_data_in <= '0';
                           slave_state <= SM_DATA;
                        end if;
               --

          when SM_DATA =>
                        if (md_transfer_cnt = "0111111" AND mdio_rd_wr = '0') THEN
                           slave_state <= SM_ST_0;
                           md_get_reg_data_in <= '0';
                           md_transfer_cnt_reset <= '1';
                           mdio_rd_wr <= '0';
                           if (phy_address = phy_addr) THEN
                              md_put_reg_data_in <= '1';
                           end if;
                        ELSIF (md_transfer_cnt = "0111110" AND mdio_rd_wr = '1') THEN
                              slave_state <= SM_ST_0;
                              md_get_reg_data_in <= '0';
                              md_transfer_cnt_reset <= '1';
                              mdio_rd_wr <= '0';
                              mdio_output_enable <= '0';
                        else
                        end if;
          when OTHERS  =>
                        slave_state <= SM_ST_0;
        end CASE;
      end if;
   end process;
		
--------------------------------------------------------------------------------
-- MDO Read Register bit Mux
---------1---------2---------3---------4---------5---------6---------7---------8 

   process (mdio_output_enable,count)
   begin		
            if (mdio_output_enable = '1') THEN
               CASE count is
                  when "00001" =>
                           mdio_output <= register_bus_out(0);
                  when "00010" =>
                           mdio_output <= register_bus_out(1);
                  when "00011" =>
                           mdio_output <= register_bus_out(2);
                  when "00100" =>
                           mdio_output <= register_bus_out(3);
                  when "00101" =>
                           mdio_output <= register_bus_out(4);
                  when "00110" =>
                           mdio_output <= register_bus_out(5);
                  when "00111" =>
                           mdio_output <= register_bus_out(6);
                  when "01000" =>
                           mdio_output <= register_bus_out(7);
                  when "01001" =>
                           mdio_output <= register_bus_out(8);
                  when "01010" =>
                           mdio_output <= register_bus_out(9);
                  when "01011" =>
                           mdio_output <= register_bus_out(10);
                  when "01100" =>
                           mdio_output <= register_bus_out(11);
                  when "01101" =>
                           mdio_output <= register_bus_out(12);
                  when "01110" =>
                           mdio_output <= register_bus_out(13);
                  when "01111" =>
                           mdio_output <= register_bus_out(14);
                  when "10000" =>
                           mdio_output <= register_bus_out(15);
                  when OTHERS =>
                           mdio_output <= '0';
               end CASE;
            else
			   mdio_output <= '0';
            end if;
   end process;

			
--------------------------------------------------------------------------------
-- Read Registers Mux
---------1---------2---------3---------4---------5---------6---------7---------8 

   process (PMAD_clk,PMAD_rst_reg)
      --VARIABLE register_bus_out_xhdl4  : std_logic_vector(15 downto 0);
   begin
     if (PMAD_rst_reg = '1') THEN
       register_bus_out <= "0000000000000000" ;
     elsif (PMAD_clk'EVENT AND PMAD_clk = '1') THEN
            if (md_put_reg_data_out = '1') THEN
               -- read enable
               CASE reg_address is
                  when "00000" =>
                           register_bus_out <= Register0 ;
                  when "00001" =>
                           register_bus_out <= Register1;
                  when "00010" =>
                           register_bus_out <= phy_id1 ;
                  when "00011" =>
                           register_bus_out <= phy_id2 ;
                  --

                  when "00100" =>
                           register_bus_out <= Register4 ;
                  when "00101" =>
                           register_bus_out <= Register5 ;
                  when "00110" =>
                           register_bus_out <= Register6 ;
                  when "00111" =>
                           register_bus_out <= Register7 ;
                  --

                  when "01000" =>
                           register_bus_out <= Register8 ;
                  when "01001" =>
                           register_bus_out <= Register9 ;
                  when "01010" =>
                           register_bus_out <= Register10 ;
                  when "01011" =>
                           register_bus_out <= Register11 ;
                  --

                  when "01100" =>
                           register_bus_out <= Register12 ;
                  when "01101" =>
                           register_bus_out <= Register13 ;
                  when "01110" =>
                           register_bus_out <= Register14 ;
                  when "01111" =>
                           register_bus_out <= Register15 ;
                  when "10000" =>
                           register_bus_out <= Register16 ;
                  when "10001" =>
                           register_bus_out <= Register17 ;

                  when OTHERS  =>
                           register_bus_out <= "0000000000000000" ;
               end CASE;
            end if;
     end if;
   end process;
		
--------------------------------------------------------------------------------
--    Writing to a selected register
---------1---------2---------3---------4---------5---------6---------7---------8 
  
  process (PMAD_clk, PMAD_rst_reg)
  begin
    if (PMAD_rst_reg = '1') THEN		
	  Register0 <= "0000000000000000" ; 
				--	5432109876543210
      Register4 <= "0000000000100001" ; 	-- 10Mbps half capable.  802.3
      Register5 <= "0000000000100001" ; 	-- 10Mbps half capable.  802.3
      Register6 <= "0000000000000000" ;
      Register7 <= "0000000000000000" ; 
      Register8 <= "0000000000000000" ;
      Register9 <= "0000000000000000" ;
      Register10 <= "0000000000000000" ;
      Register11 <= "0000000000000000" ;
      Register12 <= "0000000000000000" ;
      Register13 <= "0000000000000000" ;
      Register14 <= "0000000000000000" ;
      Register15 <= "0000000000000000" ;
      Register16 <= "0000000000000001" ;	-- override strap in for MII mode
      Register17 <= "0000000000000001" ;	-- override strap in for MII mode
    elsif (PMAD_clk'EVENT AND PMAD_clk = '1') THEN
        if (md_put_reg_data_in = '1') THEN
           CASE reg_address is
               when "00000" =>					-- preload strapping resistors into register
						Register0 <= register_bus_in(15 downto 14)	-- .15:14 Phy reset15 and loopback14 active high
						& "0"										-- .13 speed slect = 10Mb/select (LSB)
						& "0"										-- .12 disable Auto Negotiate process
						& register_bus_in(11)						-- .11 Power down active high
						& "0"										-- .10 electrically isolate PHY from MII
						& register_bus_in(9)						-- .9 restart auto negotiate not supported
						& "0"										-- .8 half duplex support only
						& register_bus_in(7)						-- .7 Enable COL signal test
						& "0000000";								-- .6:0 Reserved write 0, ignore on read
               when "00100" =>
                        Register4 <= register_bus_in ;
               when "00101" =>
                        Register5 <= register_bus_in ;
               when "00110" =>
                        Register6 <= register_bus_in ;
               when "00111" =>
                        Register7 <= register_bus_in ;
               when "01000" =>
                        Register8 <= register_bus_in ;
               when "01001" =>
                        Register9 <= register_bus_in ;
               when "01010" =>
                        Register10 <= register_bus_in ;
               when "01011" =>
                        Register11 <= register_bus_in ;
               when "01100" =>
                        Register12 <= register_bus_in ;
               when "01101" =>
                        Register13 <= register_bus_in ;
               when "01110" =>
                        Register14 <= register_bus_in ;
               when "01111" =>
                        Register15 <= register_bus_in ;
               when "10000" =>
                        Register16 <= register_bus_in ;
               when "10001" =>
                        Register17 <= register_bus_in ;
               when OTHERS  =>
           end CASE;
        end if;
    end if;
  end process;

end ARCHITECTURE translated;

--////////////////////////////////////////////////////////////////////
--//                                                              ////
--// Copyright (C) 2002  Authors                                  ////
--//                                                              ////
--// This source file may be used and distributed without         ////
--// restriction provided that this copyright statement is not    ////
--// removed from the file and that any derivative work contains  ////
--// the original copyright notice and the associated disclaimer. ////
--//                                                              ////
--// This source file is free software; you can redistribute it   ////
--// and/or modify it under the terms of the GNU Lesser General   ////
--// Public License as published by the Free Software Foundation; ////
--// either version 2.1 of the License, or (at your option) any   ////
--// later version.                                               ////
--//                                                              ////
--// This source is distributed in the hope that it will be       ////
--// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
--// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
--// PURPOSE.  See the GNU Lesser General Public License for more ////
--// details.                                                     ////
--//                                                              ////
--// You should have received a copy of the GNU Lesser General    ////
--// Public License along with this source; if not, download it   ////
--// from http://www.opencores.org/lgpl.shtml                     ////
--//                                                              ////
--////////////////////////////////////////////////////////////////////