library ieee;
use ieee.std_logic_1164.all;

entity top_mist is
port
(
    clock       : in  std_logic
);
end entity top_mist;


architecture rtl of top_mist is
        
    signal dram_clock   : std_logic;
    signal pal_clock    : std_logic;
    signal vcot         : std_logic;
    --
    signal pll_lock     : std_logic;

begin


    -- clock generators
    pll_i0: entity work.altpll0
    port map
    (
        inclk0      => clock_27,    --: in  std_logic  := '0';
        --
        c0          => dram_clock,  --: out std_logic;
        c1          => vcot,        --: out std_logic;
        c2          => pal_clock,   --: out std_logic;
        c3          => open,        --: out std_logic;
        c4          => open,        --: out std_logic;
        --
        locked      => pll_lock     --: out std_logic 
    );

end architecture rtl;

