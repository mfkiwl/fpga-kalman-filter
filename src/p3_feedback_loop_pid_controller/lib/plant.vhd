library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity Plant2ndOrder is
    Port (
        clk     : in  std_logic;
        rst     : in  std_logic;
        u       : in  integer;
        y       : out integer
    );
end Plant2ndOrder;

architecture Plant2ndOrderRTL of Plant2ndOrder is

    signal s_y : integer := 0;
    signal s_dy : integer := 0;
    signal s_ddy : integer := 0;

    constant SCALE_VALUE : integer := 1024;
    constant SCALE_DT : integer := 100;

    constant MAX_VALUE : integer := 65536000;
    constant MIN_VALUE : integer := -65536000;

    constant K : integer := 1 * SCALE_VALUE;

    constant b2 : integer := 1 * SCALE_VALUE;
    constant b1 : integer := 42 * SCALE_VALUE;
    constant b0 : integer := 1 * SCALE_VALUE;

    constant a0 : integer := 4 * SCALE_VALUE;

    component Saturation is
        Port (
            x       : in  integer;
            max_val : in  integer;
            min_val : in  integer;
            y       : out integer
        );
    end component;

    signal s_sat_in : integer;
    signal s_sat_out : integer;

begin
    process(clk, rst)
    begin
        if rst = '1' then
            s_y <= 0;
            s_dy <= 0;
            s_ddy <= 0;
            s_sat_in <= 0;
        elsif rising_edge(clk) then
            s_ddy <= (u) * (a0 / b2) - s_dy * (b1 / b2) - s_y * (b0 / b2);
            s_dy  <= s_dy + s_ddy / SCALE_DT;
            s_y   <= s_y + s_dy / SCALE_DT;

            s_sat_in <= s_y;
        end if;
    end process;

    saturation_inst : Saturation
    port map (
        max_val => MAX_VALUE,
        min_val => MIN_VALUE,
        x       => s_sat_in,
        y       => s_sat_out
    );

    y <= s_sat_out;

end Plant2ndOrderRTL;

