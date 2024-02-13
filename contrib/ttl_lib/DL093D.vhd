
-- DL 093 D      4-Bit Binärzähler                                   SN74LS93

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dl093d is
    port (
        cka : in  std_ulogic;
        ckb : in  std_ulogic;
        r01 : in  std_ulogic;
        r02 : in  std_ulogic;
        q   : out std_ulogic_vector(3 downto 0)
    );
end entity dl093d;

architecture rtl of dl093d is

    signal result: unsigned(3 downto 0) := "0000";

begin

    process( r01, r02, cka, ckb)
    begin
        if falling_edge( cka) then
            result(0) <= not result(0);
        end if;
        if falling_edge( ckb) then
            result(3 downto 1) <= result(3 downto 1) + 1;
        end if;
        if r02 = '1' or r01 = '1' then
            result <= (others => '0');
        end if;
    end process;
    
    q <= std_ulogic_vector( result);
    
end architecture rtl;
