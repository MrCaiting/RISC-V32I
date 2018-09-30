import rv32i_types::*;

module cmp(
	input branch_funct3_t cmpop,
	input rv32i_word cmpmux_out,
	input rv32i_word rs1_out,
	output logic br_en
);

logic equal, less_s, less_u;
logic [2:0] command;
assign command = cmpop;
assign equal = (rs1_out == cmpmux_out);
assign less_s = ($signed(rs1_out) < $signed(cmpmux_out));
assign less_u = (rs1_out < cmpmux_out);
logic mux_out;

mux4 #(.width (1)) four_mux(
	.sel(command[2:1]),
	.a(equal),
	.b(1'bX),
	.c(less_s),
	.d(less_u),
	.f(mux_out)
);

assign br_en = mux_out ^ command[0];

endmodule: cmp