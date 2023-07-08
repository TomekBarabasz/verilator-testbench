library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity counter is
    port(
            rst : in std_logic;
    enc_a,enc_b : in std_logic;
         digits : out std_logic_vector(11 downto 0)
    );
end counter;

architecture structural of counter is
    component single_digit_bcd_counter is
        port(
						  rst : in std_logic;
				enc_a,enc_b : in std_logic;
					 counter : out unsigned(3 downto 0);
				  enc_a_out : out std_logic;
				  enc_b_out : out std_logic
        );
    end component;
    signal enc_a_out_1,enc_b_out_1 : std_logic;
    signal enc_a_out_2,enc_b_out_2 : std_logic;
    signal digit1 : unsigned(3 downto 0);
    signal digit2 : unsigned(3 downto 0);
    signal digit3 : unsigned(3 downto 0);

begin
    digits <= std_logic_vector(digit3) & std_logic_vector(digit2) & std_logic_vector(digit1);
    c1 : single_digit_bcd_counter port map(
        rst => rst,
        enc_a => enc_a,
        enc_b => enc_b,
        counter => digit1,
        enc_a_out => enc_a_out_1,
        enc_b_out => enc_b_out_1
    );
    c2 : single_digit_bcd_counter port map(
        rst => rst,
        enc_a => enc_a_out_1,
        enc_b => enc_b_out_1,
        counter => digit2,
        enc_a_out => enc_a_out_2,
        enc_b_out => enc_b_out_2
    );
    c3 : single_digit_bcd_counter port map(
        rst => rst,
        enc_a => enc_a_out_2,
        enc_b => enc_b_out_2,
        counter => digit3,
        enc_a_out => open,
        enc_b_out => open
    );
end structural;