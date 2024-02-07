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

entity kc85_4 is
    port
    (
        reset_button_n  : in    std_logic;
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
    signal  pm2         : std_logic;
    signal  reset       : std_logic;
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
    takt    <= not pm2;
    takt1   <= not pm2;

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

end architecture rtl;
