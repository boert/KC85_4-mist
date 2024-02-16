
-- DL 299 D      8 Bit Universalschieberegister

library ieee;
use ieee.std_logic_1164.all;

entity DL299D is
port 
(
    s0      : in    std_ulogic;
    s1      : in    std_ulogic;
    --
    sl      : in    std_ulogic;
    sr      : in    std_ulogic;
    --
    clk     : in    std_ulogic;
    clr_n   : in    std_ulogic;
    oe1_n   : in    std_ulogic;
    oe2_n   : in    std_ulogic;
    --
    d       : inout std_ulogic_vector(7 downto 0);
    --
    oa      : out   std_ulogic;
    oh      : out   std_ulogic
);
end entity DL299D;


architecture rtl of DL299D is

    signal reg      : std_ulogic_vector(7 downto 0);
    signal enable   : boolean;
    
begin

    process( clr_n, s1, s0, d, clk)
    begin
        if clr_n = '0' then
            reg <= ( others => '0');
        else
            if s1 = '1' and s0 = '1' then
                -- load, disable outputs
                reg <= d;
            end if;
            if s1 = '0' and s0 = '1' then
                -- shift right
                if rising_edge( clk) then
                    reg <= sr & reg( 7 downto 1);
                end if;
            end if;
            if s1 = '1' and s0 = '0' then
                -- shift left
                if rising_edge( clk) then
                    reg <= reg( 6 downto 0) & sl;
                end if;
            end if;
            -- else hold
        end if;
    end process;

    enable  <= oe1_n = '0' and oe2_n = '0' and ( s0 = '0' or s1 = '0');
    d       <= reg     when enable else ( others => 'Z');
    oa      <= reg( 0) when enable else 'Z'; 
    oh      <= reg( 7) when enable else 'Z'; 

end architecture rtl;
