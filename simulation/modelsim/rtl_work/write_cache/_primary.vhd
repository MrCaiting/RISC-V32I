library verilog;
use verilog.vl_types.all;
entity write_cache is
    port(
        mem_byte_enable : in     vl_logic_vector(3 downto 0);
        mem_wdata       : in     vl_logic_vector(31 downto 0);
        byte_offset     : in     vl_logic_vector(4 downto 0);
        cache_mux_out   : in     vl_logic_vector(255 downto 0);
        write_cache_out : out    vl_logic_vector(255 downto 0)
    );
end write_cache;
