
-- DL 074 D      2 positiv flanken-getriggerte D-Flip-Flop           SN74LS74N 

library ieee;
use ieee.std_logic_1164.all;

entity dl074d is
    port (
        s_n : in  std_ulogic;
        clk : in  std_ulogic;
        d   : in  std_ulogic;
        r_n : in  std_ulogic;
        --
        q   : out std_ulogic;
        q_n : out std_ulogic
    );
end entity dl074d;

architecture rtl of dl074d is

    signal ff : std_ulogic := 'L';

begin

    process( s_n, clk, r_n)
    begin
        if rising_edge( clk) then
            ff  <= d;
        end if;
        if s_n = '0' then
            ff  <= '1';
        end if;
        if r_n = '0' then
            ff  <= '0';
        end if;
    end process;
    
    q   <= ff;
    q_n <= not ff;

end architecture rtl;
