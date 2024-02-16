
-- DL 374 D      8-D-Flip-Flop

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DL374D is
port 
(
    di   : in  std_ulogic_vector(7 downto 0);
    clk  : in  std_ulogic;
    oe_n : in  std_ulogic;
    --
    do   : out std_ulogic_vector(7 downto 0)
);
end entity DL374D;


architecture rtl of DL374D is

    signal reg : std_ulogic_vector(7 downto 0);
    
begin

    process
    begin
        wait until rising_edge( clk);
        reg <= di;
    end process;

    do <= reg when oe_n = '0' else (others => 'Z');

end architecture rtl;
