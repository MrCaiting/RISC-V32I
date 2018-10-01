import rv32i_types::*;

module mp2
(
    input clk,

    /* Memory signals */
    input pmem_resp,
    input [255:0] pmem_rdata,
    output pmem_read,
    output pmem_write,
    output [31:0] pmem_address,
    output [255:0]pmem_wdata
);

logic [3:0] mem_byte_enable;
logic mem_read, mem_write;
logic mem_resp;
rv32i_word mem_address;
rv32i_word mem_wdata;
rv32i_word mem_rdata;


cpu cpu
(
    .clk,
    /* Memory signals */
    .mem_resp,
    .mem_rdata,
    .mem_read,
    .mem_write,
    .mem_byte_enable,
    .mem_address,
    .mem_wdata
    );

cache cache
(
    .clk,
    .mem_byte_enable,
    .mem_address,
    .mem_wdata,
    .mem_read,
    .mem_write,
    .pmem_resp,
    .pmem_rdata,
    .pmem_address,
    .pmem_wdata,
    .pmem_read,
    .pmem_write,
    .mem_resp,
    .mem_rdata
    );

endmodule : mp2
