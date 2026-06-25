library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity cronometro is
generic ( clock_FREQ : integer := 50_000_000 );
port( 
	entrada    : in STD_LOGIC_VECTOR(7 downto 0);
	cron_clock : in STD_LOGIC;
	cron_carga : in STD_LOGIC;
	cron_reset : in STD_LOGIC;
	cron_conta : in STD_LOGIC;
	cron_stop  : out STD_LOGIC;
	min_saida  : out integer range 99 DOWNTO 0;
	seg_saida  : out integer range 59 DOWNTO 0
);
end cronometro;

architecture cronometro of cronometro is
	type states is (IDLE, LOAD, COUNT); 
	signal clock_seg : STD_LOGIC;
	signal contador  : INTEGER range 0 to clock_FREQ := 0;
	signal minutos   : INTEGER RANGE 99 DOWNTO 0;	
	SIGNAL segundos  : INTEGER RANGE 59 DOWNTO 0;
	signal nst, pst  : states; --presentstate
begin

divisor : 
	process(cron_clock)
	begin
		if rising_edge(cron_clock) then
			if contador = (clock_FREQ - 1) then
				clock_seg <= '1';
				contador <= 0;
			else
				contador <= contador + 1;
				clock_seg <= '0';
			 end if;
		end if;
	end process;
			
estado: 
	process(cron_clock)
	begin
		if rising_edge(cron_clock) then
			case pst is	--state machine
				when IDLE => 
					if cron_carga = '1' then
						pst <= nst;
					end if;
				when LOAD => 
					if cron_conta = '1' then 
						pst <= nst;
					end if;					
				when COUNT =>
					pst <= nst;
			end case;
			end if;
	end process;
	
decrementador : 
	process(clock_seg, cron_reset)
	begin
		if cron_reset = '1' then --config reset asincrono
				minutos <= 0;
				segundos <= 0;
				cron_stop <= '0';
				nst <= idle;
		else
			if rising_edge(clock_seg) then	
				if pst = idle then
					nst <= load;
				end if;
				if pst = load then
					cron_stop <= '0';
					minutos <= conv_integer(entrada);
					segundos <= 0;
					nst <= COUNT;
				end if;
				if pst = count then
					if segundos = 0 then
						if minutos = 0 then
							cron_stop <= '1';
							nst <= IDLE;
						else
							minutos <= minutos - 1; 
							segundos <= 59;         
						end if;
					else
						segundos <= segundos - 1;
					end if;
				end if;
			end if;
		end if;
	end process;
	

	min_saida <= minutos;
	seg_saida <= segundos;

end cronometro;

