library verilog;
use verilog.vl_types.all;
entity cache_control is
    port(
        clk             : in     vl_logic;
        mem_byte_enable : in     vl_logic_vector(3 downto 0);
        mem_read        : in     vl_logic;
        mem_write       : in     vl_logic;
        pmem_resp       : in     vl_logic;
        pmem_read       : out    vl_logic;
        pmem_write      : out    vl_logic;
        mem_resp        : out    vl_logic;
        hit_0           : in     vl_logic;
        hit_1           : in     vl_logic;
        valid_out_0     : in     vl_logic;
        dirty_out_0     : in     vl_logic;
        valid_out_1     : in     vl_logic;
        dirty_out_1     : in     vl_logic;
        lru_out         : in     vl_logic;
        load_data_0     : out    vl_logic;
        load_tag_0      : out    vl_logic;
        load_valid_0    : out    vl_logic;
        load_dirty_0    : out    vl_logic;
        load_data_1     : out    vl_logic;
        load_tag_1      : out    vl_logic;
        load_valid_1    : out    vl_logic;
        load_dirty_1    : out    vl_logic;
        valid_in        : out    vl_logic;
        dirty_in        : out    vl_logic;
        way_sel         : out    vl_logic;
        load_lru        : out    vl_logic;
        lru_in          : out    vl_logic
    );
end cache_control;
