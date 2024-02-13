
-- DL 090 D      Dezimalzähler                                       SN74LS90

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dl090d is
    port (
        cka   : in  std_ulogic;
        ckb   : in  std_ulogic;
        r01   : in  std_ulogic;
        r02   : in  std_ulogic;
        r91   : in  std_ulogic;
        r92   : in  std_ulogic;
        --
        q     : out std_ulogic_vector(3 downto 0)
    );
end entity dl090d;

architecture rtl of dl090d is

    signal result: unsigned(3 downto 0) := "0000";

begin

    process( r01, r02, r91, r92, cka, ckb)
    begin
        if falling_edge( cka) then
            result(0) <= not result(0);
        end if;
        if falling_edge( ckb) then
            if result(3 downto 1) = "100" then 
                result(3 downto 1) <= "000";
            else
                result(3 downto 1) <= result(3 downto 1) + 1;
            end if;
        end if;
        if r02 = '1' or r01 = '1' then
            result <= "0000"; -- 0
        end if;
        if r92 = '1' or r91 = '1' then
            result <= "1001"; -- 9 
        end if;
    end process;
    
    q <= std_ulogic_vector( result);
    
end architecture rtl;
