-- interfaces:
--  expansion interface
--  Modulschacht 08
--  Modulschacht 0C
--  Tastatur
--  Kassettentonband (in/out)
--  Audio-Out
--  Video-Out
--
-- function blocks:
--  CPU
--  bus drivers
--  Resetlogik
--  Richtungssteuerung
--  Adreßdecoder I/O
--  Speichersteuerregister
--  PIO
--  CTC
--  Tastaturinterface
--  Kassetteninterface
--  Tongenerator
--  Adreßdecoder Memory
--  ROM E-CAOS
--  ROM C-CAOS
--  ROM BASIC
--  RAM-Steuerung I
--  Adreßmultiplexer I
--  64k dRAM Arbeitsspeicher
--  Video Timing Generator
--  Adreßmultiplexer II
--  RAM-Steuerung II
--  64k dRAM Bildwiederholspeicher
--  Schieberegister I
--  Farbmultiplexer
--  Schieberegister II
--  Videointerface
--  Oszillator PLL
--  PAL-Coder
--  Modulator
--
--
-- Bezeichnungsschema: 
--  DxxyyZ
--      xx = Baugruppennummer aus Schaltplan (30, 32, 34, 44)
--      yy = Chipnummer
--      Z  = (opt.) Gatter (A..D)

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


library T80;

library TTL_LIB;
use TTL_LIB.component_package.dl074d;
use TTL_LIB.component_package.dl093d;
use TTL_LIB.component_package.DL193D;
use TTL_LIB.component_package.DL253D;
use TTL_LIB.component_package.DL299D;
use TTL_LIB.component_package.DL374D;
use TTL_LIB.component_package.U2164D;


entity kc85_4 is
    port
    (
        reset_button_n  : in    std_logic;
        vcot            : in    std_logic;
        --
        led             : out   std_logic
    );
end entity kc85_4;


architecture rtl of kc85_4 is

    signal  db          : std_logic_vector( 7 downto 0);
    signal  wait_n      : std_logic;
    signal  int_n       : std_logic;
    signal  nmi_n       : std_logic;
    signal  reset_n     : std_logic;
    signal  takt        : std_logic;
    signal  busrq_n     : std_logic;
    signal  ab          : std_logic_vector( 15 downto 0);
    signal  ab_big      : std_logic_vector( 15 downto 0);
    signal  ab_small    : std_logic_vector( 15 downto 0);
    signal  m1_n        : std_logic;
    signal  m1_n_big    : std_logic;
    signal  m1          : std_logic;
    signal  mreq_n      : std_logic;
    signal  iorq_n      : std_logic;
    signal  iorq        : std_logic;
    signal  rd_n        : std_logic;
    signal  wr_n        : std_logic;
    signal  wr_n_big    : std_logic;
    signal  rfsh_n      : std_logic;
    signal  halt_n      : std_logic;
    signal  busak_n     : std_logic;
    --
    signal  takt1       : std_logic;
    signal  reset       : std_logic;
    signal  vcot_n      : std_logic;
    signal  hzr         : std_logic;
    signal  m           : std_ulogic_vector( 3 downto 0);
    signal  d3401_uv_n  : std_logic;
    signal  d3402_uv_n  : std_logic;
    signal  h           : std_ulogic_vector( 5 downto 0);
    signal  h3_n        : std_logic;
    signal  h4_n        : std_logic;
    signal  h5_n        : std_logic;
    signal  blink_big   : std_logic;
    signal  blink       : std_logic;
    signal  d3404_q     : std_ulogic_vector( 3 downto 0);
    signal  v           : std_ulogic_vector( 7 downto 0);
    signal  vzr         : std_logic;
    signal  d3405_q     : std_ulogic_vector( 3 downto 0);
    signal  d3406_q     : std_ulogic_vector( 3 downto 0);
    signal  bi_n        : std_logic;
    signal  d3428a_q    : std_logic;
    signal  d3207a_q    : std_logic;
    signal  d3207b_q    : std_logic;
    signal  pm          : std_ulogic_vector( 3 downto 0);
    signal  pm_n        : std_ulogic_vector( 3 downto 0);
    signal  rbu_n       : std_logic;
    signal  hsy1        : std_logic;
    signal  d3434a_q    : std_logic;
    signal  d3434b_q    : std_logic;
    signal  vsy1        : std_logic;
    --
    signal  s2          : std_logic;
    signal  d3435b_q    : std_logic;
    signal  duf         : std_logic;
    signal  d3435a_q    : std_logic;
    signal  ras_n       : std_logic;
    signal  dup         : std_logic;
    signal  sig440      : std_logic;
    signal  d3436b_q    : std_logic;
    signal  d3435c_q    : std_logic;
    signal  duz         : std_logic;
    signal  d3407a_q_n  : std_logic;
    signal  cas_n       : std_logic;
    signal  d3429a_q    : std_logic;
    signal  s1_n        : std_logic;
    signal  d3440b_q    : std_logic;
    signal  ire_n       : std_logic;
    signal  mreq        : std_logic;
    signal  d3437a_q    : std_logic;
    signal  d3439c_q    : std_logic;
    signal  d3430c_q    : std_logic;
    signal  d3441d_q    : std_logic;
    signal  write_n     : std_logic;
    signal  d3439f_q    : std_logic;
    signal  oed_n       : std_logic;
    signal  d3431b_q    : std_logic;
    signal  d3431d_q    : std_logic;
    signal  d3432e_q    : std_logic;
    signal  d3434d_q    : std_logic;
    signal  syn_n       : std_logic;
    signal  d3408a_q    : std_logic;
    signal  d3433a_q    : std_logic;
    signal  d3437d_q    : std_logic;
    signal  zi_n        : std_logic;
    signal  inf         : std_logic;
    signal  inf_n       : std_logic;
    signal  bla0_big    : std_logic;
    signal  bla0        : std_logic;
    signal  block0      : std_logic;
    signal  bla1_big    : std_logic;
    signal  bla1        : std_logic;
    --
    signal  s0          : std_logic;
    signal  s1          : std_logic;
    signal  d3409_s     : std_logic_vector( 1 downto 0);
    signal  a_big       : std_logic_vector( 7 downto 0);
    signal  bild        : std_logic;
    signal  d_big       : std_logic_vector( 7 downto 0);
    signal  dp_big      : std_logic_vector( 7 downto 0);
    signal  df_big      : std_logic_vector( 7 downto 0);
    signal  d3428c_q    : std_logic;
    signal  d3440a_q    : std_logic;
    signal  blen        : std_logic;
    signal  d3440c_q    : std_logic;
    signal  bon         : std_logic;
    signal  ez_n        : std_logic;
    signal  hell_n      : std_logic;
    signal  ez          : std_logic;
    signal  hell        : std_logic;
    signal  ey          : std_logic;
    signal  ex_n        : std_logic;
    signal  er          : std_logic;
    signal  eg          : std_logic;
    signal  eb          : std_logic;
    signal  er_n        : std_logic;
    signal  eg_n        : std_logic;
    signal  eb_n        : std_logic;
    signal  fpix        : std_logic;
    --
    signal  afe         : std_logic;
    signal  meo         : std_logic;
    signal  mac_n       : std_logic;
    signal  umsr        : std_logic;
    signal  umsr_n      : std_logic;
    signal  ab65        : std_logic;
    signal  dir         : std_logic;
    signal  ioe         : std_logic;
    signal  iora        : std_logic;
    signal  ioac_n      : std_logic;
    signal  d3011b_q    : std_logic; 
    signal  d3012a_q_n  : std_logic; 
    signal  d3012b_q_n  : std_logic; 
    signal  d3015a_q3   : std_logic; 
    signal  d3015b_q1   : std_logic; 
    signal  d3017a_q    : std_logic; 
    signal  d3018d_q    : std_logic; 
    signal  d3020a_q    : std_logic; 
    signal  d3021d_q    : std_logic; 

begin


    ----------------------------------------
    -- function block: CPU

    D3001: entity T80.T80s
    generic map
    (
        Mode    => 0,                  -- : integer := 0; -- 0 => Z80, 1 => Fast Z80, 2 => 8080, 3 => GB
        T2Write => 0,                  -- : integer := 0; -- 0 => WR_n active in T3, /=0 => WR_n active in T2
        IOWait  => 1                   -- : integer := 1  -- 0 => Single cycle I/O, 1 => Std I/O cycle
    )
    port map
    (
        RESET_n => reset_n,            -- : in std_logic;
        CLK_n   => takt,               -- : in std_logic;
        WAIT_n  => wait_n,             -- : in std_logic;
        INT_n   => int_n,              -- : in std_logic;
        NMI_n   => nmi_n,              -- : in std_logic;
        BUSRQ_n => busrq_n,            -- : in std_logic;
        M1_n    => m1_n,               -- : out std_logic;
        MREQ_n  => mreq_n,             -- : out std_logic;
        IORQ_n  => iorq_n,             -- : out std_logic;
        RD_n    => rd_n,               -- : out std_logic;
        WR_n    => wr_n_big,           -- : out std_logic;
        RFSH_n  => rfsh_n,             -- : out std_logic;
        HALT_n  => halt_n,             -- : out std_logic;
        BUSAK_n => busak_n,            -- : out std_logic;
        A       => ab_big,             -- : out std_logic_vector(15 downto 0);
        DI      => db,                 -- : in std_logic_vector(7 downto 0);
        DO      => db                  -- : out std_logic_vector(7 downto 0)
    );

    ----------------------------------------
    -- function block: Takttreiber D3010
    takt    <= not pm( 2);
    takt1   <= not pm( 2);

    ----------------------------------------
    -- function block: Resetlogik
    D3015A: process( takt1, d3012B_q_n)
        variable counter : unsigned( 3 downto 0);
    begin
        if d3012B_q_n = '1' then
            counter := "0000";
        elsif rising_edge( takt1) then
            counter := counter + 1;
        end if;
        d3015A_q3   <= counter( 3);
    end process;

    D3011A: afe         <= not ( not reset_button_n and d3011B_q); 
    D3011B: d3011B_q    <= not (     reset_button_n and afe);

    D3012A: process( d3015A_q3, d3011B_q)
    begin
        if d3011B_q = '0' then
            d3012A_q_n  <= '1';
        elsif rising_edge( d3015A_q3) then
            d3012A_q_n  <= '0';
        end if;
    end process;

    D3012B: process( m1, d3012A_q_n)
    begin
        if d3012A_q_n = '0' then
            d3012B_q_n  <= '1';
        elsif rising_edge( m1) then
            d3012B_q_n  <= d3011B_q;
        end if;
    end process;

    D3011D: reset       <= not( '1' and d3012B_q_n);
    D3013:  reset_n     <= not reset;


    D3015B: process( m1_n, reset)
        variable counter : unsigned( 3 downto 0);
    begin
        if reset = '1' then
            counter := "0000";
        elsif falling_edge( m1_n) then
            counter := counter + 1;
        end if;
        d3015B_q1   <= counter( 1);
    end process;

    D3016A: process( d3015B_q1, reset_n)
    begin
        if reset_n = '0' then
            umsr    <= '0';
            umsr_n  <= '1';
        elsif rising_edge( d3015B_q1) then
            umsr    <= '0';
            umsr_n  <= '0';
        end if;
    end process;

    ----------------------------------------
    --  bus drivers

    D3002: ab_small(  7 downto 0)   <= ab_big( 7 downto 0); 
    D3003: ab_small( 15 downto 8)   <= ab_big( 15 downto 8) when umsr_n = '0' else "ZZZZZZZZ";
    D3026: ab_small( 15 downto 8)   <= "111" & afe & "0000" when umsr = '0' else "ZZZZZZZZ";

    -- D3018A, entfaellt
    D3014F: iorq        <= not iorq_n;
    -- D3014E, entfaellt
    -- D3018B, entfaellt
    R3020:  m1          <= 'H';
    D3011C: m1          <= not ( reset_n and m1_n_big);
    D3014C: m1_n        <= not m1;
    -- D3018C, entfaellt
    D3021D: d3021d_q    <= not( mac_n and ioac_n);
    D3014D: meo         <= not d3021d_q;
    D3020A: d3020a_q    <= not rd_n;
    -- D3020B, entfaellt
    -- D3020C, entfaellt
    D3018D: d3018d_q    <= d3021d_q and d3020a_q;
    D3017A: d3017a_q    <= not ioe and m1 and iora;
    D3019B: dir         <= not ( d3018d_q or d3017a_q);
    -- D3013D, entfaellt

    ab65                <= not ( ab_small( 5) or ab_small( 6)); 
    
    ----------------------------------------
    --  video timing generator
    
    -- Anfang Spalte 1
    D3432: vcot_n  <= not vcot;

    D3401: DL193D
    port map
    (
        zv      => vcot_n,      --: in  std_ulogic;
        zr      => '1',         --: in  std_ulogic;
        --      
        d       => "1111",      --: in  std_ulogic_vector(3 downto 0);
        --      
        s_n     => '1',         --: in  std_ulogic;
        r       => hzr,         --: in  std_ulogic;
        --      
        q       => m,           --: out std_ulogic_vector(3 downto 0)
        cv      => d3401_uv_n,  --: out std_ulogic;
        cr      => open         --: out std_ulogic;
    );

    D3402: DL193D
    port map
    (
        zv      => d3401_uv_n,  --: in  std_ulogic;
        zr      => '1',         --: in  std_ulogic;
        --      
        d       => "1111",      --: in  std_ulogic_vector(3 downto 0);
        --      
        s_n     => '1',         --: in  std_ulogic;
        r       => hzr,         --: in  std_ulogic;
        --      
        q       => h( 3 downto 0),  --: out std_ulogic_vector(3 downto 0)
        cv      => d3402_uv_n,  --: out std_ulogic;
        cr      => open         --: out std_ulogic;
    );


    D3403A: dl074d
    port map
    (
        s_n     => '1',         --: in  std_ulogic;
        clk     => d3402_uv_n,  --: in  std_ulogic;
        d       => h4_n,        --: in  std_ulogic;
        r_n     => not hzr,     --: in  std_ulogic;
        --
        q       => h( 4),       --: out std_ulogic;
        q_n     => h4_n         --: out std_ulogic
    );


    D3403B: dl074d
    port map
    (
        s_n     => '1',         --: in  std_ulogic;
        clk     => h4_n,        --: in  std_ulogic;
        d       => h5_n,        --: in  std_ulogic;
        r_n     => not hzr,     --: in  std_ulogic;
        --
        q       => h( 5),       --: out std_ulogic;
        q_n     => h5_n         --: out std_ulogic
    );

    D3404: dl093d
    port map
    (
        cka     => blink_big,   --: in  std_ulogic;
        ckb     => h( 5),       --: in  std_ulogic;
        r01     => '0',         --: in  std_ulogic;
        r02     => '0',         --: in  std_ulogic;
        --
        q       => d3404_q      --: out std_ulogic_vector(3 downto 0)
    );
    blink   <= d3404_q( 0);
    v( 0)   <= d3404_q( 1);
    v( 1)   <= d3404_q( 2);
    
    D3405: dl093d
    port map
    (
        cka     => v( 1),       --: in  std_ulogic;
        ckb     => v( 2),       --: in  std_ulogic;
        r01     => vzr,         --: in  std_ulogic;
        r02     => vzr,         --: in  std_ulogic;
        --
        q       => d3405_q      --: out std_ulogic_vector(3 downto 0)
    );
    v( 2)   <= d3405_q( 0);
    v( 3)   <= d3405_q( 1);
    v( 4)   <= d3405_q( 2);
    v( 5)   <= d3405_q( 3);
    
    D3406: dl093d
    port map
    (
        cka     => '0',         --: in  std_ulogic;
        ckb     => v( 5),       --: in  std_ulogic;
        r01     => vzr,         --: in  std_ulogic;
        r02     => vzr,         --: in  std_ulogic;
        --
        q       => d3406_q      --: out std_ulogic_vector(3 downto 0)
    );
    v( 6)   <= d3406_q( 1);
    v( 7)   <= d3406_q( 2);
    bi_n    <= d3406_q( 3);

    D3428A: d3428a_q    <= pm( 3) and m( 1)          after 20 ns;
    D3207A: d3207a_q    <= h( 5) and h( 4) and h( 3) after 20 ns;
    D3428B: hzr         <= d3428a_q and d3207a_q     after 20 ns;

    D3431A: vzr         <= bi_n and v( 4) and v( 3) and v( 5);

    D3432C: h3_n        <= not h( 3);
    D3207B: d3207b_q    <= h( 1) and h( 4) and h( 5);
    D3433C: rbu_n       <= not( h3_n and not h( 2) and d3207b_q);
    D3433B: hsy1        <= not( h4_n and h( 3) and h( 2));
    D3434B: d3434b_q    <= not( v( 6) and v( 7));
    D3434A: d3434a_q    <= not( v( 3) and v( 5));
    D3436C: vsy1        <= not( d3434b_q and d3434a_q);
    pm_n                <= not m;
    pm                  <=     m;
    -- Ende Spalte 1

    -- Anfang Spalte 2
    D3429C: S2          <= pm( 2) and pm( 3);
    D3435C: d3435c_q    <= not( pm_n( 2) and pm_n( 3) and pm_n( 1));
    D3438F: duf         <= not d3435c_q;
    D3435B: d3435b_q    <= not( pm( 2) and m( 1) and pm_n( 3));
    D3436A: ras_n       <= not( d3435c_q and d3435b_q);
    D3438E: dup         <= not d3435b_q;
    D3436B: d3436b_q    <= not( d3435c_q and d3435b_q); -- wie /ras 
    D3439B: sig440      <= not( not( d3436b_q));        -- /ras um einge ns verzögert
    D3435A: d3435a_q    <= not( pm( 3) and pm( 2) and pm_n( 1));
    D3438D: duz         <= not d3435a_q;

    D3407A: dl074d
    port map
    (
        s_n     => '1',         --: in  std_ulogic;
        clk     => m( 0),       --: in  std_ulogic;
        d       => d3436b_q,    --: in  std_ulogic;
        r_n     => '1',         --: in  std_ulogic;
        --
        q       => open,        --: out std_ulogic;
        q_n     => d3407a_q_n   --: out std_ulogic
    );

    D3436D: cas_n       <= not( d3435a_q and d3407a_q_n);
    D3429A: d3429a_q    <= pm_n( 3) and pm_n( 2);

    D3407B: dl074d
    port map
    (
        s_n     => '1',         --: in  std_ulogic;
        clk     => m( 0),       --: in  std_ulogic;
        d       => d3429a_q,    --: in  std_ulogic;
        r_n     => '1',         --: in  std_ulogic;
        --
        q       => open,        --: out std_ulogic;
        q_n     => s1_n         --: out std_ulogic
    );

    D3440B: d3440b_q    <= not ire_n;
    D3437A: d3437a_q    <= not( mreq and d3440b_q);
    D3439C: d3439c_q    <= not d3437a_q;
    D3073C: wait_n      <= '0' when s1_n and d3439c_q else 'Z'; -- OC
    D3430C: d3430c_q    <= pm_n( 3) and d3441d_q;
    D3441D: d3441d_q    <= not wr_n;
    D3437C: write_n     <= not( d3439c_q and d3441d_q);
    D3439F: d3439f_q    <= not rd_n;
    D3437B: oed_n       <= not( d3439c_q and d3439f_q);

    D3434D: d3434d_q    <= not( vsy1 and d3431b_q);
    D3431B: d3431b_q    <= not( v( 4) and v( 2) and bi_n);
    D3432E: d3432e_q    <= not d3431d_q;
    D3428D: syn_n       <= d3432e_q and d3408a_q;

    D3408A: dl074d
    port map
    (
        s_n     => h( 5),       --: in  std_ulogic;
        clk     => h( 0),       --: in  std_ulogic;
        d       => hsy1,        --: in  std_ulogic;
        r_n     => '1',         --: in  std_ulogic;
        --
        q       => d3408a_q,    --: out std_ulogic;
        q_n     => open         --: out std_ulogic
    );

    D3433A: d3433a_q    <= not( h4_n and h( 5) and h3_n);
    D3437D: d3437d_q    <= not( d3433a_q and h( 5));

    D3408B: dl074d
    port map
    (
        s_n     => '1',         --: in  std_ulogic;
        clk     => d3437d_q,    --: in  std_ulogic;
        d       => h( 0),       --: in  std_ulogic;
        r_n     => '1',         --: in  std_ulogic;
        --
        q       => open,        --: out std_ulogic;
        q_n     => zi_n         --: out std_ulogic
    );

    D3434C: inf         <= not( bi_n or zi_n);
    D3439E: inf_n       <= not inf;
    D3430A: bla0        <= bla0_big and block0;
    D3430B: bla1        <= bla1_big and block0;


    -- Ende Spalte 2

    -- Anfang Spalte 3
    d3409_s <= not s1 & s0;
    D3409: dl253d
    port map
    (
        d1       => v( 0) & v( 2) & ab_small( 0) & ab_small( 2),    --: in  std_ulogic_vector(3 downto 0);
        d2       => v( 1) & v( 3) & ab_small( 1) & ab_small( 3),    --: in  std_ulogic_vector(3 downto 0);
        --       
        s        => d3409_s,                                        --: in  std_ulogic_vector(1 downto 0);
        oe1_n    => '0',                                            --: in  std_ulogic;
        oe2_n    => '0',                                            --: in  std_ulogic;
        --       
        y1       => A_big( 0),                                      --: out std_ulogic;
        y2       => A_big( 1)                                       --: out std_ulogic
    );
    
    D3410: dl253d
    port map
    (
        d1       => h( 0) & v( 4) & ab_small( 8) & ab_small( 4),    --: in  std_ulogic_vector(3 downto 0);
        d2       => h( 1) & v( 5) & ab_small( 9) & ab_small( 5),    --: in  std_ulogic_vector(3 downto 0);
        --       
        s        => d3409_s,                                        --: in  std_ulogic_vector(1 downto 0);
        oe1_n    => '0',                                            --: in  std_ulogic;
        oe2_n    => '0',                                            --: in  std_ulogic;
        --       
        y1       => A_big( 2),                                      --: out std_ulogic;
        y2       => A_big( 3)                                       --: out std_ulogic
    );
    
    D3413: U2164D
    generic map
    (
        seed1  =>   5,                  --: positive := 3;
        seed2  =>   6                   --: positive := 4
    )
    port map
    (
        a      => A_big( 7 downto 0),   --: in    std_logic_vector(7 downto 0);
        ras_n  => ras_n,                --: in    std_logic;
        cas_n  => cas_n,                --: in    std_logic;
        wr_n   => write_n,              --: in    std_logic;
        di     => db( 0),               --: in    std_logic;
        --
        do     => d_big( 0)             --: out   std_logic
    );
   

    D3414: U2164D
    generic map
    (
        seed1  =>   7,                  --: positive := 3;
        seed2  =>   8                   --: positive := 4
    )
    port map
    (
        a      => A_big( 7 downto 0),   --: in    std_logic_vector(7 downto 0);
        ras_n  => ras_n,                --: in    std_logic;
        cas_n  => cas_n,                --: in    std_logic;
        wr_n   => write_n,              --: in    std_logic;
        di     => db( 1),               --: in    std_logic;
        --
        do     => d_big( 1)             --: out   std_logic
    );
   

    D3415: U2164D
    generic map
    (
        seed1  =>   9,                  --: positive := 3;
        seed2  =>   10                  --: positive := 4
    )
    port map
    (
        a      => A_big( 7 downto 0),   --: in    std_logic_vector(7 downto 0);
        ras_n  => ras_n,                --: in    std_logic;
        cas_n  => cas_n,                --: in    std_logic;
        wr_n   => write_n,              --: in    std_logic;
        di     => db( 2),               --: in    std_logic;
        --
        do     => d_big( 2)             --: out   std_logic
    );
   

    D3416: U2164D
    generic map
    (
        seed1  =>   11,                 --: positive := 3;
        seed2  =>   12                  --: positive := 4
    )
    port map
    (
        a      => A_big( 7 downto 0),   --: in    std_logic_vector(7 downto 0);
        ras_n  => ras_n,                --: in    std_logic;
        cas_n  => cas_n,                --: in    std_logic;
        wr_n   => write_n,              --: in    std_logic;
        di     => db( 3),               --: in    std_logic;
        --
        do     => d_big( 3)             --: out   std_logic
    );
    -- Ende Spalte 3

    
    -- Anfang Spalte 4
    D3411: dl253d
    port map
    (
        d1       => h( 2) & v( 6) & ab_small( 10) & ab_small( 6),   --: in  std_ulogic_vector(3 downto 0);
        d2       => h( 3) & v( 7) & ab_small( 11) & ab_small( 7),   --: in  std_ulogic_vector(3 downto 0);
        --       
        s        => d3409_s,                                        --: in  std_ulogic_vector(1 downto 0);
        oe1_n    => '0',                                            --: in  std_ulogic;
        oe2_n    => '0',                                            --: in  std_ulogic;
        --       
        y1       => A_big( 4),                                      --: out std_ulogic;
        y2       => A_big( 5)                                       --: out std_ulogic
    );
    
    D3412: dl253d
    port map
    (
        d1       => h( 4) & s2    & ab_small( 12) & bla0,           --: in  std_ulogic_vector(3 downto 0);
        d2       => h( 5) & bild  & ab_small( 13) & bla1,            --: in  std_ulogic_vector(3 downto 0);
        --       
        s        => d3409_s,                                        --: in  std_ulogic_vector(1 downto 0);
        oe1_n    => '0',                                            --: in  std_ulogic;
        oe2_n    => '0',                                            --: in  std_ulogic;
        --       
        y1       => A_big( 6),                                      --: out std_ulogic;
        y2       => A_big( 7)                                       --: out std_ulogic
    );
   

    D3417: U2164D
    generic map
    (
        seed1  =>   13,                 --: positive := 3;
        seed2  =>   14                  --: positive := 4
    )
    port map
    (
        a      => A_big( 7 downto 0),   --: in    std_logic_vector(7 downto 0);
        ras_n  => ras_n,                --: in    std_logic;
        cas_n  => cas_n,                --: in    std_logic;
        wr_n   => write_n,              --: in    std_logic;
        di     => db( 4),               --: in    std_logic;
        --
        do     => d_big( 4)             --: out   std_logic
    );
   

    D3418: U2164D
    generic map
    (
        seed1  =>   15,                 --: positive := 3;
        seed2  =>   16                  --: positive := 4
    )
    port map
    (
        a      => A_big( 7 downto 0),   --: in    std_logic_vector(7 downto 0);
        ras_n  => ras_n,                --: in    std_logic;
        cas_n  => cas_n,                --: in    std_logic;
        wr_n   => write_n,              --: in    std_logic;
        di     => db( 5),               --: in    std_logic;
        --
        do     => d_big( 5)             --: out   std_logic
    );
   

    D3419: U2164D
    generic map
    (
        seed1  =>   17,                 --: positive := 3;
        seed2  =>   18                  --: positive := 4
    )
    port map
    (
        a      => A_big( 7 downto 0),   --: in    std_logic_vector(7 downto 0);
        ras_n  => ras_n,                --: in    std_logic;
        cas_n  => cas_n,                --: in    std_logic;
        wr_n   => write_n,              --: in    std_logic;
        di     => db( 6),               --: in    std_logic;
        --
        do     => d_big( 6)             --: out   std_logic
    );
   

    D3420: U2164D
    generic map
    (
        seed1  =>   19,                 --: positive := 3;
        seed2  =>   20                  --: positive := 4
    )
    port map
    (
        a      => A_big( 7 downto 0),   --: in    std_logic_vector(7 downto 0);
        ras_n  => ras_n,                --: in    std_logic;
        cas_n  => cas_n,                --: in    std_logic;
        wr_n   => write_n,              --: in    std_logic;
        di     => db( 7),               --: in    std_logic;
        --
        do     => d_big( 7)             --: out   std_logic
    );
    -- Ende Spalte 4
    

    -- Anfang Spalte 5
    -- Latch für Prozessor
    D3421: DL374D
    port map
    (
        di   => D_big,                  --: in  std_ulogic_vector(7 downto 0);
        clk  => dup,                    --: in  std_ulogic;
        oe_n => oed_n,                  --: in  std_ulogic;
        --
        do   => db                      --: out std_ulogic_vector(7 downto 0)
    );
    

    -- Latch für Pixel
    D3422: DL374D
    port map
    (
        di   => D_big,                  --: in  std_ulogic_vector(7 downto 0);
        clk  => duz,                    --: in  std_ulogic;
        oe_n => '0',                    --: in  std_ulogic;
        --
        do   => dp_big                  --: out std_ulogic_vector(7 downto 0)
    );
    

    -- Latch für Farbe
    D3423: DL374D
    port map
    (
        di   => D_big,                  --: in  std_ulogic_vector(7 downto 0);
        clk  => d3428c_q,               --: in  std_ulogic;
        oe_n => '0',                    --: in  std_ulogic;
        --
        do   => df_big                  --: out std_ulogic_vector(7 downto 0)
    );

    D3428C: d3428c_q    <= m( 0) and duf;
    R3404:  df_big( 0)  <= 'L'; -- pull down
    R3405:  df_big( 1)  <= 'L'; -- pull down
    R3406:  df_big( 2)  <= 'L'; -- pull down

    D3440A: d3440a_q    <= not( df_big( 7) and blink and blen);
    D3440C: d3440c_q    <= not( bon and d3440a_q);
    D3430D: ez_n        <= d3440c_q and hell_n;
    R3407:  hell_n      <= 'H'; -- pull up
    D3441E: ez          <= not ez_n;
    D3439D: hell        <= not hell_n;

    -- Ende Spalte 5
    

    -- Anfang Spalte 6
    D3424: DL299D
    port map
    (
        s0      => '1',                 --: in    std_ulogic;
        s1      => duf,                 --: in    std_ulogic;
        --
        sl      => '0',                 --: in    std_ulogic;
        sr      => '0',                 --: in    std_ulogic;
        --
        clk     => m( 0),               --: in    std_ulogic;
        clr_n   => inf,                 --: in    std_ulogic;
        oe1_n   => '1',                 --: in    std_ulogic;
        oe2_n   => '1',                 --: in    std_ulogic;
        --
        d       => dp_big,              --: inout std_ulogic_vector(7 downto 0);
        --
        oa      => bon,                 --: out   std_ulogic;
        oh      => open                 --: out   std_ulogic
    );
    
    D3425: DL253D
    port map
    (
        d1       => df_big( 3) & df_big( 0) & ey  & ey,
        d2       => df_big( 4) & df_big( 1) & '1' & '0',
        --       
        s        => fpix & ez,                                      --: in  std_ulogic_vector(1 downto 0);
        oe1_n    => hell,                                           --: in  std_ulogic;
        oe2_n    => hell,                                           --: in  std_ulogic;
        --       
        y1       => eb,                                             --: out std_ulogic;
        y2       => er                                              --: out std_ulogic
    );
    D3441A: eb_n    <= eb;
    D3441B: er_n    <= er;
    D3441C: eg_n    <= eg;
    
    D3426: DL253D
    port map
    (
        d1       => df_big( 5) & df_big( 2) & ey  & ey,
        d2       => df_big( 6) & '1'    & '0' & '0',
        --       
        s        => fpix & ez,                                      --: in  std_ulogic_vector(1 downto 0);
        oe1_n    => hell,                                           --: in  std_ulogic;
        oe2_n    => hell,                                           --: in  std_ulogic;
        --       
        y1       => eg,                                             --: out std_ulogic;
        y2       => ex_n                                            --: out std_ulogic
    );

    D3427: DL299D
    port map
    (
        s0      => '1',                 --: in    std_ulogic;
        s1      => duf,                 --: in    std_ulogic;
        --
        sl      => '0',                 --: in    std_ulogic;
        sr      => '0',                 --: in    std_ulogic;
        --
        clk     => m( 0),               --: in    std_ulogic;
        clr_n   => inf,                 --: in    std_ulogic;
        oe1_n   => '1',                 --: in    std_ulogic;
        oe2_n   => '1',                 --: in    std_ulogic;
        --
        d       => d_big,               --: inout std_ulogic_vector(7 downto 0);
        --
        oa      => open,                --: out   std_ulogic;
        oh      => ey                   --: out   std_ulogic
    );

    -- Ende Spalte 6

end architecture rtl;
