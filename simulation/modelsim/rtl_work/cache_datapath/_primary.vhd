library verilog;
use verilog.vl_types.all;
entity cache_datapath is
    port(
        clk             : in     vl_logic;
        mem_byte_enable : in     vl_logic_vector(3 downto 0);
        mem_address     : in     vl_logic_vector(31 downto 0);
        mem_wdata       : in     vl_logic_vector(31 downto 0);
        pmem_rdata      : in     vl_logic_vector(255 downto 0);
        load_data_0     : in     vl_logic;
        load_tag_0      : in     vl_logic;
        load_valid_0    : in     vl_logic;
        load_dirty_0    : in     vl_logic;
        load_data_1     : in     vl_logic;
        load_tag_1      : in     vl_logic;
        load_valid_1    : in     vl_logic;
        load_dirty_1    : in     vl_logic;
        valid_in        : in     vl_logic;
        dirty_in        : in     vl_logic;
        way_sel         : in     vl_logic;
        load_lru        : in     vl_logic;
        lru_in          : in     vl_logic;
        pmem_sel        : in     vl_logic_vector(1 downto 0);
        data_sel        : in     vl_logic;
        load_pmem_wdata : in     vl_logic;
        pmem_address    : out    vl_logic_vector(31 downto 0);
        pmem_wdata      : out    vl_logic_vector(255 downto 0);
        mem_rdata       : out    vl_logic_vector(31 downto 0);
        hit_0           : out    vl_logic;
        hit_1           : out    vl_logic;
        valid_out_0     : out    vl_logic;
        dirty_out_0     : out    vl_logic;
        valid_out_1     : out    vl_logic;
        dirty_out_1     : out    vl_logic;
        lru_out         : out    vl_logic
    );
end cache_datapath;
