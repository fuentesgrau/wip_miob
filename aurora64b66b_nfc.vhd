----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/16/2025 11:06:36 AM
-- Design Name: 
-- Module Name: aurora_nfc - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

----------------------------------------------------------------
--    contol aurora NFC signal to circumvent FIFO overflow    --  
----------------------------------------------------------------

entity aurora64b66b_nfc is
    Port ( aclk : in STD_LOGIC;
           m_axi_nfc_tdata : out STD_LOGIC_VECTOR (15 downto 0);
           m_axi_nfc_tready : in STD_LOGIC;
           m_axi_nfc_tvalid : out STD_LOGIC;
           stop_rx : in STD_LOGIC;
           start_rx : in STD_LOGIC);
end aurora64b66b_nfc;

architecture Behavioral of aurora64b66b_nfc is
  signal await_on_off : STD_LOGIC := '0';  -- 0: awaiting stop, 1: awaiting start
  signal tvalid : STD_LOGIC := '0';
  constant XON : STD_LOGIC_VECTOR (15 downto 0) := "0000000000000000";
  constant XOFF : STD_LOGIC_VECTOR (15 downto 0) := "0000000111111111";

begin

  process (aclk, stop_rx, start_rx) begin
    if rising_edge(aclk) then
      if stop_rx = '1' and await_on_off = '0' then
        m_axi_nfc_tdata <= XOFF; -- XOFF signal
        m_axi_nfc_tvalid <= '1';
        await_on_off <= '1';
        tvalid <= '1';
      elsif start_rx = '1' and await_on_off = '1' then -- hold valid until tready asserted
        m_axi_nfc_tvalid <= '1';
        m_axi_nfc_tdata <= XON; -- XON signal
        await_on_off <= '0';
        tvalid <= '1';
       elsif m_axi_nfc_tready = '1' and tvalid = '1' then
        m_axi_nfc_tvalid <= '0';
        tvalid <= '0';
      end if;
    end if;
  end process; 

end Behavioral;
