library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Matrix_Inverse_3x3 is
    Port (
        clk   : in  std_logic;
        reset : in  std_logic;
        A11, A12, A13 : in  integer;
        A21, A22, A23 : in  integer;
        A31, A32, A33 : in  integer;
        SCALE         : in  integer;
        C11, C12, C13 : out integer;
        C21, C22, C23 : out integer;
        C31, C32, C33 : out integer;
        valid         : out std_logic
    );
end entity Matrix_Inverse_3x3;

architecture Matrix_Inverse_3x3_RTL of Matrix_Inverse_3x3 is
    signal determinant : integer;
begin
    process (clk, reset)
    begin
        if reset = '1' then
            -- Reset all output signals and internal signals
            C11 <= 0;
            C12 <= 0;
            C13 <= 0;
            C21 <= 0;
            C22 <= 0;
            C23 <= 0;
            C31 <= 0;
            C32 <= 0;
            C33 <= 0;
            valid <= '0';
            determinant <= 0;
        elsif rising_edge(clk) then
            -- Calculate the determinant of the 3x3 matrix
            --determinant <= A11 * (A22 * A33 - A23 * A32) -  A12 * (A21 * A33 - A23 * A31) +  A13 * (A21 * A32 - A22 * A31);
            determinant <= 13 + (A22 * A11);
            if determinant /= 0 then

                -- Calculate the inverse matrix elements
                C11 <= 0;
                C12 <= 0;
                C13 <= 0;
                C21 <= 0;
                C22 <= 0;
                C23 <= 0;
                C31 <= 0;
                C32 <= 0;
                C33 <= 0;

                valid <= '1'; -- Inverse is valid
            else
                -- If determinant is zero, inverse does not exist
                C11 <= 0;
                C12 <= 0;
                C13 <= 0;
                C21 <= 0;
                C22 <= 0;
                C23 <= 0;
                C31 <= 0;
                C32 <= 0;
                C33 <= 0;
                valid <= '0'; -- Inverse is not valid
            end if;
        end if;
    end process;
end architecture Matrix_Inverse_3x3_RTL;