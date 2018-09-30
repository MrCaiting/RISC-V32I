library verilog;
use verilog.vl_types.all;
entity mux16 is
    generic(
        width           : integer := 32
    );
    port(
        sel             : in     vl_logic_vector(3 downto 0);
        zero            : in     vl_logic_vector;
        one             : in     vl_logic_vector;
        two             : in     vl_logic_vector;
        three           : in     vl_logic_vector;
        four            : in     vl_logic_vector;
        five            : in     vl_logic_vector;
        six             : in     vl_logic_vector;
        seven           : in     vl_logic_vector;
        eight           : in     vl_logic_vector;
        nine            : in     vl_logic_vector;
        ten             : in     vl_logic_vector;
        eleven          : in     vl_logic_vector;
        twelve          : in     vl_logic_vector;
        thirt           : in     vl_logic_vector;
        fourte          : in     vl_logic_vector;
        fift            : in     vl_logic_vector;
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
end mux16;
