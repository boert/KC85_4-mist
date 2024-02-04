library ieee;
use ieee.std_logic_1164.all;

entity taktgeber_tb is
end entity taktgeber_tb;


architecture testbench of taktgeber_tb is
        
    signal tb_pal_clock   : std_logic;
    signal tb_vcot        : std_logic;

begin

    dut: entity work.taktgeber
    port map
    (
        pal_clock   => tb_pal_clock,   --: out std_logic;
        vcot        => tb_vcot         --: out std_logic
    );

    process
    begin
        report "Simulation started." severity note;
        wait for 50 ms;
        report "Simulation stopped." severity failure;
        wait;
    end process;

end architecture testbench;
