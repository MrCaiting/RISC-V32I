import rv32i_types::*;

module mp2
(
    input clk,

    /* Memory signals */
    input mem_resp,
    input [31:0] mem_rdata,
    output mem_read,
    output mem_write,
    output [3:0] mem_byte_enable,
    output [31:0] mem_address,
    output [31:0] mem_wdata
);


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

endmodule : mp2
