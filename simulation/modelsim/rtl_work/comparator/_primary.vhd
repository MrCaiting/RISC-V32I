library verilog;
use verilog.vl_types.all;
entity comparator is
    port(
        a               : in     vl_logic_vector(23 downto 0);
        b               : in     vl_logic_vector(23 downto 0);
        valid_bit       : in     vl_logic;
        equal           : out    vl_logic
    );
end comparator;
