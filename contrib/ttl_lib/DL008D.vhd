
-- DL 008 D      4 AND mit je 2 Eingängen                            SN74LS08

library ieee;
use ieee.std_logic_1164.all;

entity dl008d is
    port (
        a : in  std_ulogic;
        b : in  std_ulogic;
        q : out std_ulogic
      );
end entity dl008d;

architecture rtl of dl008d is

begin
    
    q <= (a and b);

end architecture rtl;
