
-- DL 253 D      zweifach 4-auf-1 Multiplexer mit Tristate-Ausgängen   SN74LS253N

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DL253D is
port 
(
    d1       : in  std_ulogic_vector(3 downto 0);
    d2       : in  std_ulogic_vector(3 downto 0);
    --       
    s        : in  std_ulogic_vector(1 downto 0);
    oe1_n    : in  std_ulogic;
    oe2_n    : in  std_ulogic;
    --       
    y1       : out std_ulogic;
    y2       : out std_ulogic
);
end entity DL253D;


architecture rtl of DL253D is
    
begin

    y1 <= d1( to_integer( to_01( unsigned( s)))) when oe1_n = '0' else 'Z';
    y2 <= d2( to_integer( to_01( unsigned( s)))) when oe2_n = '0' else 'Z';

end architecture rtl;
