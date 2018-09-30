library verilog;
use verilog.vl_types.all;
library work;
entity cmp is
    port(
        cmpop           : in     work.rv32i_types.branch_funct3_t;
        cmpmux_out      : in     vl_logic_vector(31 downto 0);
        rs1_out         : in     vl_logic_vector(31 downto 0);
        br_en           : out    vl_logic
    );
end cmp;
