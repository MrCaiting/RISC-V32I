import rv32i_types::*;

module cache
(
    input clk,

    /* Signals from CPU */
    input rv32rv32i_mem_wmask mem_byte_enable,
    input rv32i_word mem_address,
    input rv32i_word mem_wdata,
    input mem_read,
    input mem_write,

    /* Signals from P-memory */
    input pmem_resp,
    input rv32i_cacheline pmem_rdata,

    /* Signals to P-memory */
    output rv32i_word pmem_address,
    output rv32i_cacheline pmem_wdata,
    output logic pmem_read,
    output logic pmem_write,

    /* Signals to CPU */
    output logic mem_resp,
    output rv32i_word mem_rdata
    );

logic hit_0, hit_1;
logic valid_out_0, dirty_out_0;
logic valid_out_1, dirty_out_1;
logic lru_out;
logic load_data_0, load_tag_0, load_valid_0, load_dirty_0;
logic load_data_1, load_tag_1, load_valid_1, load_dirty_1;

logic valid_in, dirty_in, lru_in;
logic way_sel;
logic load_lru;

cache_control control
(
    .clk,
    .mem_byte_enable,
    .mem_read,
    .mem_write,
    .pmem_resp,
    .pmem_read,
    .pmem_write,
    .mem_resp,
    .hit_0,
    .hit_1,
    .valid_out_0,
    .dirty_out_0,
    .valid_out_1,
    .dirty_out_1,
    .lru_out,
    .load_data_0,
    .load_tag_0,
    .load_valid_0,
    .load_dirty_0,
    .load_data_1,
    .load_tag_1,
    .load_valid_1,
    .load_dirty_1,
    .valid_in,
    .dirty_in,
    .way_sel,
    .load_lru,
    .lru_in
    );

module cache_datapath
(
    .clk,
    .mem_byte_enable,
    .mem_address,
    .mem_wdata,
    .pmem_rdata,
    .load_data_0,
    .load_tag_0,
    .load_valid_0,
    .load_dirty_0,
    .load_data_1,
    .load_tag_1,
    .load_valid_1,
    .load_dirty_1,
    .valid_in,
    .dirty_in,
    .way_sel,
    .load_lru,
    .lru_in,
    .pmem_address,
    .pmem_wdata,
    .mem_rdata,
    .hit_0,
    .hit_1,
    .valid_out_0,
    .dirty_out_0,
    .valid_out_1,
    .dirty_out_1,
    .lru_out
    );


endmodule : cache
