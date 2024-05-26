
--------------------------------------------------------------------------------
-- Title		: Memória da CPU
-- Project		: CPU Multi-ciclo
--------------------------------------------------------------------------------
-- File			: Memoria.vhd
-- Author		: Emannuel Gomes Macêdo <egm@cin.ufpe.br>
--				  Fernando Raposo Camara da Silva <frcs@cin.ufpe.br>
--				  Pedro Machado Manhães de Castro <pmmc@cin.ufpe.br>
--				  Rodrigo Alves Costa <rac2@cin.ufpe.br>
-- Organization : Universidade Federal de Pernambuco
-- Created		: 26/07/2002
-- Last update	: 23/11/2002
-- Plataform	: Flex10K
-- Simulators	: Altera Max+plus II
-- Synthesizers	: 
-- Targets		: 
-- Dependency	: 
--------------------------------------------------------------------------------
-- Description	: Entidade responsável pela leitura e escrita em memória.
--------------------------------------------------------------------------------
-- Copyright (c) notice
--		Universidade Federal de Pernambuco (UFPE).
--		CIn - Centro de Informatica.
--		Developed by computer science undergraduate students.
--		This code may be used for educational and non-educational purposes as 
--		long as its copyright notice remains unchanged. 
--------------------------------------------------------------------------------
-- Revisions		: 1
-- Revision Number	: 1.0
-- Version			: 1.1
-- Date				: 23/11/2002
-- Modifier			: Marcus Vinicius Lima e Machado <mvlm@cin.ufpe.br>
--				  	  Paulo Roberto Santana Oliveira Filho <prsof@cin.ufpe.br>
--					  Viviane Cristina Oliveira Aureliano <vcoa@cin.ufpe.br>
-- Description		:
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Revisions		: 2
-- Revision Number	: 2
-- Version			: 1.2
-- Date				: 31/01/2021
-- Modifier			: André Soares da Silva Filho <assf@cin.ufpe.br>
-- Description		: Simplified the code to work better in ModelSim 20.1.1
--					  -Retirada biblioteca STD_LOGIC_ARITH que conflita com a mais recente NUMERIC_STD
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Revisions		: 3
-- Revision Number	: 3
-- Version			: 1.3
-- Date				: 23/02/2023
-- Modifier			: João Victor da Silva <jvs2@cin.ufpe.br>
-- Description		: Changed byte distribution logic throughout memories
--					  -Cada memória armazena apenas endereços no formato 4n ou 4n + 1 ou 4n + 2 ou 4n + 3,
--						evitando assim que a leitura seja feita em memórias erradas
--------------------------------------------------------------------------------

PACKAGE ram_constants IS
	CONSTANT DATA_WIDTH : INTEGER := 8;
	CONSTANT ADDR_WIDTH : INTEGER := 8;
	CONSTANT INIT_FILE : STRING := "instrucoes.mif";
END ram_constants;

--*************************************************************************
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
-- USE ieee.std_logic_arith.all;						-- Retirado na versão 1.2
USE IEEE.NUMERIC_STD.ALL;

LIBRARY lpm;
USE lpm.lpm_components.ALL;

LIBRARY work;
USE work.ram_constants.ALL;
--*************************************************************************

--Short name: mem
ENTITY Memoria IS
	PORT (
		Address : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- Endereço de memória a ser lido
		Clock : IN STD_LOGIC; -- Clock do sistema
		Wr : IN STD_LOGIC; -- Indica se a memória será lida (0) ou escrita (1)
		Datain : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- Valor lido da memória quando Wr = 0
		Dataout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- Valor a ser escrito quando Wr = 1
	);
END Memoria;

-- Arquitetura que define o comportamento da memória
-- Simulation
ARCHITECTURE behavioral_arch OF Memoria IS

	SIGNAL addrL0 : STD_LOGIC_VECTOR (ADDR_WIDTH - 1 DOWNTO 0);
	SIGNAL addrL1 : STD_LOGIC_VECTOR (ADDR_WIDTH - 1 DOWNTO 0);
	SIGNAL addrL2 : STD_LOGIC_VECTOR (ADDR_WIDTH - 1 DOWNTO 0);
	SIGNAL addrL3 : STD_LOGIC_VECTOR (ADDR_WIDTH - 1 DOWNTO 0);
	SIGNAL addrN0 : STD_LOGIC_VECTOR (ADDR_WIDTH - 1 DOWNTO 0);
	SIGNAL addrN1 : STD_LOGIC_VECTOR (ADDR_WIDTH - 1 DOWNTO 0);
	SIGNAL addrN2 : STD_LOGIC_VECTOR (ADDR_WIDTH - 1 DOWNTO 0);
	SIGNAL addrN3 : STD_LOGIC_VECTOR (ADDR_WIDTH - 1 DOWNTO 0);

	SIGNAL dataoutS : STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL datainS : STD_LOGIC_VECTOR (31 DOWNTO 0);

	SIGNAL dataoutS0 : STD_LOGIC_VECTOR (DATA_WIDTH - 1 DOWNTO 0);
	SIGNAL dataoutS1 : STD_LOGIC_VECTOR (DATA_WIDTH - 1 DOWNTO 0);
	SIGNAL dataoutS2 : STD_LOGIC_VECTOR (DATA_WIDTH - 1 DOWNTO 0);
	SIGNAL dataoutS3 : STD_LOGIC_VECTOR (DATA_WIDTH - 1 DOWNTO 0);
	SIGNAL datainS0 : STD_LOGIC_VECTOR (DATA_WIDTH - 1 DOWNTO 0);
	SIGNAL datainS1 : STD_LOGIC_VECTOR (DATA_WIDTH - 1 DOWNTO 0);
	SIGNAL datainS2 : STD_LOGIC_VECTOR (DATA_WIDTH - 1 DOWNTO 0);
	SIGNAL datainS3 : STD_LOGIC_VECTOR (DATA_WIDTH - 1 DOWNTO 0);

	SIGNAL wrS : STD_LOGIC;
	SIGNAL clockS : STD_LOGIC;

	SIGNAL addr : INTEGER;

	SIGNAL rotdelay0 : INTEGER;
	SIGNAL rotdelay1 : INTEGER;
	SIGNAL rotdelay2 : INTEGER;

BEGIN

	wrS <= wr;
	clockS <= clock;

	-- Conversão do endereço no formato INTEGER
	addr <= TO_INTEGER(unsigned(Address(7 DOWNTO 0)));

	-- Cálculo dos endereços de cada byte e conversão no formato STD_LOGIC_VECTOR
	addrL0 <= STD_LOGIC_VECTOR(to_unsigned(addr + 3, ADDR_WIDTH));
	addrL1 <= STD_LOGIC_VECTOR(to_unsigned(addr + 2, ADDR_WIDTH));
	addrL2 <= STD_LOGIC_VECTOR(to_unsigned(addr + 1, ADDR_WIDTH));
	addrL3 <= STD_LOGIC_VECTOR(to_unsigned(addr, ADDR_WIDTH));

	-- Conversão dos endereços para ficarem no formato 4n, 4n+1, 4n+2, 4n+3
	addrN0 <= addrL0(ADDR_WIDTH - 1 DOWNTO 2) & "00";
	addrN1 <= addrL1(ADDR_WIDTH - 1 DOWNTO 2) & "01";
	addrN2 <= addrL2(ADDR_WIDTH - 1 DOWNTO 2) & "10";
	addrN3 <= addrL3(ADDR_WIDTH - 1 DOWNTO 2) & "11";

	-- Distribuição dos vetores de dados para os bancos de memória 
	datainS0 <= datainS(7 DOWNTO 0);
	datainS1 <= datainS(15 DOWNTO 8);
	datainS2 <= datainS(23 DOWNTO 16);
	datainS3 <= datainS(31 DOWNTO 24);

	dataoutS(7 DOWNTO 0) <= dataoutS0;
	dataoutS(15 DOWNTO 8) <= dataoutS1;
	dataoutS(23 DOWNTO 16) <= dataoutS2;
	dataoutS(31 DOWNTO 24) <= dataoutS3;

	-- Cálculo da quantidade de rotações necessárias para a entrada e saída
	rotdelay0 <= to_integer(unsigned(Address(1 DOWNTO 0)));

	-- Rotação da entrada para que os bytes correspondam com os endereços
	datainS <= datain((31 - rotdelay0 * 8) DOWNTO 0) & datain(31 DOWNTO 31 - (rotdelay0 * 8 - 1));

	-- Rotação da saída para desfazer rotação da entrada
	dataout <= dataoutS((rotdelay2 * 8 - 1) DOWNTO 0) & dataoutS(31 DOWNTO (rotdelay2 * 8));

	-- Propaga valor da quantidade de rotações para ser usado na saída
	PROCESS (clockS)
	BEGIN
		IF rising_edge(clockS) THEN
			rotdelay1 <= rotdelay0;
			rotdelay2 <= rotdelay1;
		END IF;
	END PROCESS;

	-- Bancos de memórias (cada banco possui 256 bytes)

	-- Armazena os endereços no formato 4n
	MEM : lpm_ram_dq
	GENERIC MAP(lpm_widthad => ADDR_WIDTH, lpm_width => DATA_WIDTH, lpm_file => INIT_FILE)
	PORT MAP(data => datainS0, Address => addrN0, we => wrS, inclock => clockS, outclock => clockS, q => dataoutS0);

	-- Armazena os endereços no formato 4n + 1
	MEM_plus_One : lpm_ram_dq
	GENERIC MAP(lpm_widthad => ADDR_WIDTH, lpm_width => DATA_WIDTH, lpm_file => INIT_FILE)
	PORT MAP(data => datainS1, Address => addrN1, we => wrS, inclock => clockS, outclock => clockS, q => dataoutS1);

	-- Armazena os endereços no formato 4n + 2
	MEM_plus_Two : lpm_ram_dq
	GENERIC MAP(lpm_widthad => ADDR_WIDTH, lpm_width => DATA_WIDTH, lpm_file => INIT_FILE)
	PORT MAP(data => datainS2, Address => addrN2, we => wrS, inclock => clockS, outclock => clockS, q => dataoutS2);

	-- Armazena os endereços no formato 4n + 3
	MEM_plus_Three : lpm_ram_dq
	GENERIC MAP(lpm_widthad => ADDR_WIDTH, lpm_width => DATA_WIDTH, lpm_file => INIT_FILE)
	PORT MAP(data => datainS3, Address => addrN3, we => wrS, inclock => clockS, outclock => clockS, q => dataoutS3);

END behavioral_arch;