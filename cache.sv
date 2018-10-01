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


endmodule : cache
