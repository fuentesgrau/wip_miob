----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/20/2025 01:57:30 PM
-- Design Name: 
-- Module Name: aurora_nfc_tb - Behavioral
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

entity aurora64b66b_nfc_tb is
--  Port ( );
end aurora64b66b_nfc_tb;

architecture Behavioral of aurora64b66b_nfc_tb is
  component aurora64b66b_nfc is
    Port (
           aclk               : in STD_LOGIC;
           m_axi_nfc_tdata    : out STD_LOGIC_VECTOR (15 downto 0);
           m_axi_nfc_tready   : in STD_LOGIC;
           m_axi_nfc_tvalid   : out STD_LOGIC;
           stop_rx            : in STD_LOGIC;
           start_rx           : in STD_LOGIC
         );
  end component;
     signal aclk              : STD_LOGIC := '0';
     signal out_m_axi_nfc_tdata   : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
     signal in_m_axi_nfc_tready  : STD_LOGIC := '0';
     signal out_m_axi_nfc_tvalid  : STD_LOGIC := '0';
     signal in_stop_rx           : STD_LOGIC := '0';
     signal in_start_rx          : STD_LOGIC := '0';

begin
  instance_aurora64b66b_nfc : component aurora64b66b_nfc port map(
    aclk => aclk,
    m_axi_nfc_tdata => out_m_axi_nfc_tdata,
    m_axi_nfc_tready => in_m_axi_nfc_tready,
    m_axi_nfc_tvalid => out_m_axi_nfc_tvalid,
    stop_rx => in_stop_rx,
    start_rx => in_start_rx
  );

  -- 100Mhz clock -> change to true clk (through 100Mhz fits aurora8b10b)
  aclk <= not aclk after 10ns;

  process begin
    wait for 30ns;
    in_stop_rx <= '1';
    wait until rising_edge(aclk);
    wait until rising_edge(aclk);
    in_m_axi_nfc_tready <= '1';
    wait until rising_edge(aclk);
    wait until rising_edge(aclk);
    in_m_axi_nfc_tready <= '0';
    wait until rising_edge(aclk);
    wait until rising_edge(aclk);
    in_stop_rx <= '0';
    wait until rising_edge(aclk);
    wait until rising_edge(aclk);
    in_start_rx <= '1';
    wait until rising_edge(aclk);
    wait until rising_edge(aclk);
    in_m_axi_nfc_tready <= '1';
    wait until rising_edge(aclk);
    wait until rising_edge(aclk);
    in_m_axi_nfc_tready <= '0';
    wait until rising_edge(aclk);
    wait until rising_edge(aclk);
  end process;

end Behavioral;
