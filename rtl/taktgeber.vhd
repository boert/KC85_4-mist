library ieee;
use ieee.std_logic_1164.all;

library ttl_lib;
use ttl_lib.component_package.dl000d;
use ttl_lib.component_package.dl074d;
use ttl_lib.component_package.dl090d;
use ttl_lib.component_package.dl093d;


entity taktgeber is
port
(
    pal_clock   : out std_logic;
    vcot        : out std_logic
);
end entity taktgeber;


architecture sim of taktgeber is

    constant xtal_freq      : natural   := 8867238;  -- 8,86 MHz
    constant xtal_period    : time      := 1 sec / xtal_freq;
    --
    constant vco_min_freq   : natural   := 12900000;    -- 12,9 MHz, gemessen
    constant vco_max_freq   : natural   := 16800000;    -- 16,8 MHz, gemessen

    signal xtal             : std_logic := '0';
    signal vco              : std_logic := '0';         -- expect: 14187580,8 Hz
    signal vco_frequency    : natural   := vco_min_freq;
    signal xl4              : std_logic;
    signal xl5              : std_logic;
    signal xl6              : std_logic;
    --
    signal d408_3q          : std_logic;
    signal d409_q           : std_ulogic_vector(3 downto 0);
    signal d410_q           : std_ulogic_vector(3 downto 0);
    signal d411_1q          : std_logic;
    signal d411_1q_n        : std_logic;
    signal d411_2q          : std_logic;

begin

    xtal        <= not xtal after xtal_period / 2;
    vco         <= not vco  after ( 1 sec / vco_frequency) / 2; -- works
    
    pal_clock   <= xtal;
    xl6         <= xtal;
    
    D408_3: dl000d
    port map
    (
        a     => d411_1q,       --: in  std_ulogic;
        b     => d411_2q,       --: in  std_ulogic;
        q     => d408_3q        --: out std_ulogic
    );

    vcot        <= vco;
    D409: dl093d
    port map 
    (
        cka   => d409_q( 3),    --: in  std_ulogic;
        ckb   => vco,           --: in  std_ulogic;
        r01   => '0',           --: in  std_ulogic;
        r02   => '0',           --: in  std_ulogic;
        --
        q     => d409_q         --: out std_ulogic_vector(3 downto 0)
    );
    xl4 <= d409_q( 0);
    
    D410: dl090d
    port map
    (
        cka   => d410_q( 3),    --: in  std_ulogic;
        ckb   => xtal,          --: in  std_ulogic;
        r01   => '0',           --: in  std_ulogic;
        r02   => '0',           --: in  std_ulogic;
        r91   => '0',           --: in  std_ulogic;
        r92   => '0',           --: in  std_ulogic;
        --
        q     => d410_q         --: out std_ulogic_vector(3 downto 0)
    );
    xl5 <= d410_q( 0);
    
    D411_1: dl074d
    port map 
    (
        s_n    => '1',          --: in  std_ulogic;
        clk    => xl4,          --: in  std_ulogic;
        d      => '1',          --: in  std_ulogic;
        r_n    => d408_3q,      --: in  std_ulogic;
        --
        q      => d411_1q,      --: out std_ulogic;
        q_n    => d411_1q_n     --: out std_ulogic
    );
    
    D411_2: dl074d
    port map 
    (
        s_n    => '1',          --: in  std_ulogic;
        clk    => xl5,          --: in  std_ulogic;
        d      => '1',          --: in  std_ulogic;
        r_n    => d408_3q,      --: in  std_ulogic;
        --
        q      => d411_2q,      --: out std_ulogic;
        q_n    => open          --: out std_ulogic
    );

    vco_sim: process
        constant vco_step       : integer    := 1;
        constant div            : integer    := 80000;
        variable d411_1q_old    : std_logic;
        variable d411_2q_old    : std_logic;
    begin
        wait for xtal_period / 11;
        if d411_2q = '1' and d411_2q_old = '0' then
            vco_frequency   <= vco_frequency + (vco_max_freq - vco_frequency) / div;
            -- report "faster" & integer'image( (vco_max_freq - vco_frequency) / div);
        end if;
        if d411_1q = '1' and d411_1q_old = '0' then
            vco_frequency   <= vco_frequency - (vco_frequency - vco_min_freq) / div;
            -- report "slower " & integer'image( (vco_frequency - vco_min_freq) / div);
        end if;
        d411_1q_old := d411_1q;
        d411_2q_old := d411_2q;
        --report integer'image( vco_frequency);
    end process;


end architecture sim;
