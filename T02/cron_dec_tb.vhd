--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:23:11 05/17/2026
-- Design Name:   
-- Module Name:   /home/ise/HDL/Cronometro_Decrescente_Nexys/cron_dec_tb.vhd
-- Project Name:  trabalho02
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: cron_dec
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY cron_dec_tb IS
END cron_dec_tb;
 
ARCHITECTURE behavior OF cron_dec_tb IS
	
   signal ucf_clock : std_logic := '1'; 
   signal ucf_reset : std_logic;
   signal ucf_carga : std_logic;
   signal ucf_conta : std_logic;
   --  as chaves com o valor binário 5 (conforme exemplo do professor)
   signal ucf_A     : std_logic_vector(6 downto 0) := "0000101"; 

   -- Saídas
   signal ucf_stop  : std_logic;
   -- Não  declarar sinais para o dec_ddp e an, pois 'open'

BEGIN 
   -- Inverte o sinal a cada 10 ns (Período total de 20 ns = 50 MHz)
   ucf_clock <= not ucf_clock after 10 ns;
	
   -- O reset começa ativado ('1') e desliga para sempre ('0') no instante 73 ns
   ucf_reset <= '1', '0' after 73 ns;
	
	-- O botão carga dá um "clique" (sobe em 133 ns e desce em 425 ns)
   ucf_carga <= '0', '1' after 133 ns, '0' after 425 ns;
   
   -- O botão conta dá um "clique" logo em seguida para iniciar o cronômetro
   ucf_conta <= '0', '1' after 543 ns, '0' after 925 ns;
 
   uut: entity work.cron_dec
      generic map (
         --Acelera o tempo, 1 segundo passa a valer 4 pulsos de clock
         CLOCK_FREQ => 4 
      )
		port map (
         ucf_clock   => ucf_clock,
         ucf_reset   => ucf_reset,
         ucf_carga   => ucf_carga,
         ucf_conta   => ucf_conta,
         ucf_A       => ucf_A,
         ucf_stop    => ucf_stop,
         -- A palavra 'open' deixa a porta solta, ignorando os displays na simulação
         ucf_dec_ddp => open, 
         ucf_an      => open  
      );
    
END behavior;
	
