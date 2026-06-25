library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.rom.ALL;

entity cron_dec is
generic ( CLOCK_FREQ : integer := 50_000_000 );
port(
	ucf_clock    : IN STD_LOGIC;
    ucf_reset    : IN STD_LOGIC;
	ucf_carga    : IN STD_LOGIC;
	ucf_conta    : IN STD_LOGIC;
	ucf_A        : IN STD_LOGIC_VECTOR (6 downto 0);
    ucf_stop     : OUT STD_LOGIC;
	ucf_dec_ddp  : out STD_LOGIC_VECTOR (7 downto 0);
	ucf_an       : out STD_LOGIC_VECTOR (3 downto 0)
	);
end cron_dec;

architecture cron_dec of cron_dec is
    signal minutos_BCD  : STD_LOGIC_VECTOR(7 downto 0);
    signal segundos_BCD : STD_LOGIC_VECTOR(7 downto 0);
    signal s_d3         : STD_LOGIC_VECTOR (5 downto 0);
    signal s_d2         : STD_LOGIC_VECTOR (5 downto 0);
    signal s_d1         : STD_LOGIC_VECTOR (5 downto 0);
    signal s_d0         : STD_LOGIC_VECTOR (5 downto 0);
    signal dec_minutos  : INTEGER RANGE 99 downto 0; 
    signal dec_segundos : INTEGER RANGE 59 downto 0; 
begin
        
    reader: entity work.cronometro 
		  generic map ( CLOCK_FREQ => CLOCK_FREQ )
        port map (
             entrada(7)          => '0',
             entrada(6 downto 0) => ucf_A,
             min_saida           => dec_minutos,
             seg_saida           => dec_segundos,
             cron_carga          => ucf_carga,
             cron_conta          => ucf_conta,
             cron_clock          => ucf_clock,
             cron_reset          => ucf_reset,
             cron_stop           => ucf_stop
        );

    display_driver : entity work.dspl_drv 
        port map(
            dsp_an      => ucf_an, 
            dsp_dec_ddp => ucf_dec_ddp, 
            dsp_d0      => s_d0,
            dsp_d1      => s_d1,
            dsp_d2      => s_d2,
            dsp_d3      => s_d3,
            dsp_clock   => ucf_clock, 
            dsp_reset   => ucf_reset
        );
    
    minutos_BCD  <= conv_to_BCD(dec_minutos);
    segundos_BCD <= conv_to_BCD(dec_segundos);

    s_d0 <= '1' & segundos_BCD(3 downto 0) & '1';
    s_d1 <= '1' & segundos_BCD(7 downto 4) & '1';
    s_d2 <= '1' & minutos_BCD(3 downto 0)  & '1';
    s_d3 <= '1' & minutos_BCD(7 downto 4)  & '1';
    
end cron_dec;

