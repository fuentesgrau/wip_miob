----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/18/2022 05:22:21 PM
-- Design Name: 
-- Module Name: aurora_demo - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity aurora64b66b_reset is
    Port ( clk : in STD_LOGIC;
           locked : in STD_LOGIC;
           reset_pb : out STD_LOGIC;
           pma_init : out STD_LOGIC
           );
end aurora64b66b_reset;

architecture Behavioral of aurora64b66b_reset is
    signal clk_cnt : integer := 0;
    signal do_reset_pb : std_logic := '1';
    signal do_pma_init : std_logic := '1';       
begin

reset_pb <= do_reset_pb;
pma_init <= do_pma_init;

process (clk, clk_cnt,locked) begin
    if rising_edge(clk) then
        if locked = '1' and (do_reset_pb = '1' or do_pma_init = '1') then
            clk_cnt <= clk_cnt + 1;
        end if;
        if clk_cnt >= 300 then
            do_reset_pb <= '0';
        end if;
        if clk_cnt >= 600 then
            do_pma_init <= '0';
        end if;
    end if;
end process;
    
end Behavioral;
