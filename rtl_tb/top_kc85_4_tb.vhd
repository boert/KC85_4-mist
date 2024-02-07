library ieee;
use ieee.std_logic_1164.all;


entity top_kc85_4_tb is
end entity top_kc85_4_tb;


architecture testbench of top_kc85_4_tb is

    signal simulation_run   : boolean   := true;

    constant vcot_frequency : natural   := 14187581;
    constant pal_frequency  : natural   :=  8867238;
    constant vcot_period    : time      := ( 1 sec) / vcot_frequency;
    constant pal_period     : time      := ( 1 sec) / pal_frequency;

    
    signal tb_vcot              : std_logic := '0';
    signal tb_pal_clock         : std_logic := '0';
    --
    signal tb_reset_button_n    : std_logic := '1';
    signal tb_led               : std_logic;

begin

    -- clock generators
    tb_vcot         <= not tb_vcot      after vcot_period / 2 when simulation_run;
    tb_pal_clock    <= not tb_pal_clock after pal_period  / 2 when simulation_run;


    -- reset generator
    tb_reset_button_n   <= '0', '1' after 1 us;


    dut: entity work.kc85_4
    port map
    (
        reset_button_n  => tb_reset_button_n,   --: in    std_logic;
        vcot            => tb_vcot,             --: in    std_logic;
        --
        led             => tb_led               --: out   std_logic
    );


    process
    begin
        report "Simulation start.";
        wait for 10 ms;
        report "20% done.";
        wait for 10 ms;
        report "40% done.";
        wait for 10 ms;
        report "60% done.";
        wait for 10 ms;
        report "80% done.";
        wait for 10 ms;
        report "Simulation end.";
        simulation_run  <= false;
        wait;   -- forever
    end process;

end architecture testbench;
