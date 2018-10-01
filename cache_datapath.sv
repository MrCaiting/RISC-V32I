import rv32i_types::*;

module cache_datapath
(
    input clk,

    /* Signals from CPU */
    input rv32rv32i_mem_wmask mem_byte_enable,
    input rv32i_word mem_address,
    input rv32i_word mem_wdata,

    /* Signals from P-memory */
    input rv32i_cacheline pmem_rdata,

    /* Signals from Cache Control */
    input logic load_data_0,
    input logic load_tag_0,
    input logic load_valid_0,
    input logic load_dirty_0,

    input logic load_data_1,
    input logic load_tag_1,
    input logic load_valid_1,
    input logic load_dirty_1,

    input logic valid_in,
    input logic dirty_in,
    input logic way_sel,

    /* Signals to P-memory */
    output rv32i_word pmem_address,
    output rv32i_cacheline pmem_wdata,

    /* Signals to CPU */
    output rv32i_word mem_rdata,

    /* Signals from cache arrays */
    output logic hit_0,
    output logic hit_1,
    output logic valid_out_0,
    output logic dirty_out_0,
    output logic valid_out_1,
    output logic dirty_out_1
    );

/* All the necesssary internal signals */
rv32i_cache_index index;
rv32i_cache_offset byte_offset;
rv32i_cache_tag tag_in;
rv32i_cache_tag tag_0, tag_1;
rv32i_cacheline data_0, data_1;
rv32i_cacheline cache_mux_out;
logic[5:0] one_sel, two_sel, three_sel;

/* Signals assignment */
assign tag_in = mem_address[31:8];
assign index = mem_address[7:5];
assign byte_offset = mem_address[4:0];
assign one_sel = byte_offset + 1;
assign two_sel = byte_offset + 2;
assign three_sel = byte_offset + 3;

/* The cache way 0 */
array data_array0
(
    .clk,
    .write(load_data_0),
    .index,
    .datain(pmem_rdata),
    .dataout(data_0)
    );

array #(.width(24)) tag_array0
(
	.clk,
	.write(load_tag_0),
	.index,
	.datain(tag_in),
	.dataout(tag_0)
    );

array #(.width(1)) valid_array0
(
    .clk,
    .write(load_valid_0),
    .index,
    .datain(valid_in),
    .dataout(valid_out_0)
    );

array #(.width(1)) dirty_array0
(
    .clk,
    .write(load_dirty_0),
    .index,
    .datain(dirty_in),
    .dataout(dirty_out_0)
    );

comparator compare_0
(
    .a(tag_in),
    .b(tag_0),
    .valid_bit(valid_out_0),
    .equal(hit_0)
    );


/* The cache way 1 */
array data_array1
(
    .clk,
    .write(load_data_1),
    .index,
    .datain(pmem_rdata),
    .dataout(data_1)
    );

array #(.width(24)) tag_array1
(
	.clk,
	.write(load_tag_1),
	.index,
	.datain(tag_in),
	.dataout(tag_1)
    );

array #(.width(1)) valid_array1
(
    .clk,
    .write(load_valid_1),
    .index,
    .datain(valid_in),
    .dataout(valid_out_1)
    );

array #(.width(1)) dirty_array1
(
    .clk,
    .write(load_dirty_1),
    .index,
    .datain(dirty_in),
    .dataout(dirty_out_1)
    );

comparator compare_1
(
    .a(tag_in),
    .b(tag_1),
    .valid_bit(valid_out_1),
    .equal(hit_1)
    );

/* The cache way MUX */
mux2 #(.width(256)) cache_way_mux
(
    .sel(way_sel),
    .a(data_array0),
    .b(data_array1),
    .f(cache_mux_out)
    );

/* The byte-choosing MUXes */
mux32 zero_byte_mux
(
    .sel_in(byte_offset),
	.a(cache_mux_out[7:0]), .b(cache_mux_out[15:8]),
    .c(cache_mux_out[23:16]), .d(cache_mux_out[31:24]),
    .e(cache_mux_out[39:32]), .f(cache_mux_out[47:40]),
    .g(cache_mux_out[55:48]), .h(cache_mux_out[63:56]),
    .i(cache_mux_out[71:64]), .j(cache_mux_out[79:72]),
    .k(cache_mux_out[87:80]), .l(cache_mux_out[95:88]),
    .m(cache_mux_out[103:96]), .n(cache_mux_out[111:104]),
    .o(cache_mux_out[119:112]), .p(cache_mux_out[127:120]),
    // Next 16 inputs
    .a1(cache_mux_out[135:128]), .b1(cache_mux_out[143:136]]),
    .c1(cache_mux_out[151:144]), .d1(cache_mux_out[159:152]),
    .e1(cache_mux_out[167:160]), .f1(cache_mux_out[175:168]),
    .g1(cache_mux_out[183:176]), .h1(cache_mux_out[191:184]),
    .i1(cache_mux_out[199:192]), .j1(cache_mux_out[207:200]),
    .k1(cache_mux_out[215:208]), .l1(cache_mux_out[223:216]),
    .m1(cache_mux_out[231:224]), .n1(cache_mux_out[239:232]),
    .o1(cache_mux_out[247:240]), .p1(cache_mux_out[255:248]),
	.out(mem_rdata[7:0])
);

mux32 second_byte_mux
(
    .sel_in(one_sel[4:0]),
	.a(cache_mux_out[7:0]), .b(cache_mux_out[15:8]),
    .c(cache_mux_out[23:16]), .d(cache_mux_out[31:24]),
    .e(cache_mux_out[39:32]), .f(cache_mux_out[47:40]),
    .g(cache_mux_out[55:48]), .h(cache_mux_out[63:56]),
    .i(cache_mux_out[71:64]), .j(cache_mux_out[79:72]),
    .k(cache_mux_out[87:80]), .l(cache_mux_out[95:88]),
    .m(cache_mux_out[103:96]), .n(cache_mux_out[111:104]),
    .o(cache_mux_out[119:112]), .p(cache_mux_out[127:120]),
    // Next 16 inputs
    .a1(cache_mux_out[135:128]), .b1(cache_mux_out[143:136]]),
    .c1(cache_mux_out[151:144]), .d1(cache_mux_out[159:152]),
    .e1(cache_mux_out[167:160]), .f1(cache_mux_out[175:168]),
    .g1(cache_mux_out[183:176]), .h1(cache_mux_out[191:184]),
    .i1(cache_mux_out[199:192]), .j1(cache_mux_out[207:200]),
    .k1(cache_mux_out[215:208]), .l1(cache_mux_out[223:216]),
    .m1(cache_mux_out[231:224]), .n1(cache_mux_out[239:232]),
    .o1(cache_mux_out[247:240]), .p1(cache_mux_out[255:248]),
	.out(mem_rdata[15:8])
);

mux32 third_byte_mux
(
    .sel_in(two_sel),
	.a(cache_mux_out[7:0]), .b(cache_mux_out[15:8]),
    .c(cache_mux_out[23:16]), .d(cache_mux_out[31:24]),
    .e(cache_mux_out[39:32]), .f(cache_mux_out[47:40]),
    .g(cache_mux_out[55:48]), .h(cache_mux_out[63:56]),
    .i(cache_mux_out[71:64]), .j(cache_mux_out[79:72]),
    .k(cache_mux_out[87:80]), .l(cache_mux_out[95:88]),
    .m(cache_mux_out[103:96]), .n(cache_mux_out[111:104]),
    .o(cache_mux_out[119:112]), .p(cache_mux_out[127:120]),
    // Next 16 inputs
    .a1(cache_mux_out[135:128]), .b1(cache_mux_out[143:136]]),
    .c1(cache_mux_out[151:144]), .d1(cache_mux_out[159:152]),
    .e1(cache_mux_out[167:160]), .f1(cache_mux_out[175:168]),
    .g1(cache_mux_out[183:176]), .h1(cache_mux_out[191:184]),
    .i1(cache_mux_out[199:192]), .j1(cache_mux_out[207:200]),
    .k1(cache_mux_out[215:208]), .l1(cache_mux_out[223:216]),
    .m1(cache_mux_out[231:224]), .n1(cache_mux_out[239:232]),
    .o1(cache_mux_out[247:240]), .p1(cache_mux_out[255:248]),
	.out(mem_rdata[23:16])
);

mux32 forth_byte_mux
(
    .sel_in(three_sel),
	.a(cache_mux_out[7:0]), .b(cache_mux_out[15:8]),
    .c(cache_mux_out[23:16]), .d(cache_mux_out[31:24]),
    .e(cache_mux_out[39:32]), .f(cache_mux_out[47:40]),
    .g(cache_mux_out[55:48]), .h(cache_mux_out[63:56]),
    .i(cache_mux_out[71:64]), .j(cache_mux_out[79:72]),
    .k(cache_mux_out[87:80]), .l(cache_mux_out[95:88]),
    .m(cache_mux_out[103:96]), .n(cache_mux_out[111:104]),
    .o(cache_mux_out[119:112]), .p(cache_mux_out[127:120]),
    // Next 16 inputs
    .a1(cache_mux_out[135:128]), .b1(cache_mux_out[143:136]]),
    .c1(cache_mux_out[151:144]), .d1(cache_mux_out[159:152]),
    .e1(cache_mux_out[167:160]), .f1(cache_mux_out[175:168]),
    .g1(cache_mux_out[183:176]), .h1(cache_mux_out[191:184]),
    .i1(cache_mux_out[199:192]), .j1(cache_mux_out[207:200]),
    .k1(cache_mux_out[215:208]), .l1(cache_mux_out[223:216]),
    .m1(cache_mux_out[231:224]), .n1(cache_mux_out[239:232]),
    .o1(cache_mux_out[247:240]), .p1(cache_mux_out[255:248]),
	.out(mem_rdata[31:24])
);

endmodule : cache_datapath
