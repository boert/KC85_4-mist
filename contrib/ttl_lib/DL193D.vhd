
-- DL 193 D      4-Bit synchroner Vor-/Rückwärtszähler               SN74LS193

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DL193D is
port 
(
    d   : in  std_ulogic_vector(3 downto 0);
    zv  : in  std_ulogic;
    zr  : in  std_ulogic;
    s_n : in  std_ulogic;
    r   : in  std_ulogic;
    --
    q   : out std_logic_vector(3 downto 0);
    cv  : out std_ulogic;   -- carry forward
    cr  : out std_ulogic    -- carry backward / borrow
);
end entity DL193D;

architecture rtl of DL193D is

begin

    process(r, s_n, zv, zr)
        variable result : unsigned( 3 downto 0) := (others => '0');
        variable res_n  : unsigned( 3 downto 0);
    begin
        if rising_edge(zv) and zr = '1' then
            result := result + 1;
        end if;

        if rising_edge(zr) and zv = '1' then
            result := result - 1;
        end if;

        if r = '1' then
            result := (others => '0');
        end if;

        if s_n = '0' then
            result :=  unsigned( '0' & d);
        end if;

        res_n   := not result;

        q   <= std_logic_vector( result);
        cv  <= not( zv and q( 3) and q( 2) and q( 1) and q( 0));
        cr  <= not( zr and res_n( 3) and res_n( 2) and res_n( 1) and res_n( 0)); 

    end process;
    
end architecture rtl;
