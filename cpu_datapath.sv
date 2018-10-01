import rv32i_types::*;

module cpu_datapath
(
	 input clk,

     /* control signals */
     input pcmux_sel,
     input load_pc,

	 // Added by me
	 input cmpmux_sel,
	 input branch_funct3_t cmpop,
	 input alu_ops aluop,
	 input jalr,
	 input load_ir,
	 input load_regfile,
	 input load_mdr,
	 input load_mar,
	 input load_data_out,
	 input alumux1_sel,
	 input marmux_sel,
	 input [2:0] alumux2_sel,
	 input [31:0] mem_rdata,
	 input [3:0] regfilemux_sel,

    /* declare more ports here */
	 output rv32i_opcode opcode,
	 output [2:0] funct3,
	 output [6:0] funct7,
	 output [31:0] mem_wdata,
	 output [31:0] mem_address,
	 output br_en
);

/* declare internal signals */
rv32i_word pcmux_out, pcmux2_out;
rv32i_word pc_out;
rv32i_word alu_out, alu_out_mod;
rv32i_word pc_plus4_out;

// for cmpmux and cmp
rv32i_word rs1_out, rs2_out, cmpmux_out;

// for IR
rv32i_word i_imm, s_imm, b_imm, u_imm, j_imm;
rv32i_word mdrreg_out;
rv32i_reg rs1, rs2, rd;

// for regfile
rv32i_word regfilemux_out;

// for ALU mux
rv32i_word alumux1_out, alumux2_out;

// for MAR mux and MAR
rv32i_word marmux_out;
rv32i_word zext_br_en;
rv32i_word mdr_sext;
rv32i_word mdr_lh, mdr_lhu;
rv32i_word mdr_lb, mdr_lbu;

/* Assignment goes here*/
assign pc_plus4_out = pc_out + 4;
assign zext_br_en = {31'd0, br_en};
assign alu_out_mod = {alu_out[31:1], 1'b0};
assign mdr_lh = {{17{mdrreg_out[15]}}, mdrreg_out[14:0]};
assign mdr_lhu = {16'd0, mdrreg_out[15:0]};
assign mdr_lb = {{25{mdrreg_out[7]}}, mdrreg_out[6:0]};
assign mdr_lbu = {24'd0, mdrreg_out[7:0]};

/*PC MUX*/
mux2 pcmux
(
    .sel(pcmux_sel),
    .a(pc_plus4_out),
    .b(pcmux2_out),
    .f(pcmux_out)
);

/*PC MUX 2*/
mux2 pcmux2
(
	.sel(jalr),
	.a(alu_out),
	.b(alu_out_mod),	// when it is jalr, the result from
	.f(pcmux2_out)
);

/*CMP MUX*/
mux2 cmpmux
(
	.sel(cmpmux_sel),
	.a(rs2_out),
	.b(i_imm),
	.f(cmpmux_out)
);

/*ALU MUX 1*/
mux2 alumux1
(
	.sel(alumux1_sel),
	.a(rs1_out),
	.b(pc_out),
	.f(alumux1_out)
);

/*MAR MUX*/
mux2 marmux
(
	.sel(marmux_sel),
	.a(pc_out),
	.b(alu_out),
	.f(marmux_out)
);

/*ALU MUX 2*/
mux8 alumux2
(
	.sel(alumux2_sel),
	.a(i_imm),
	.b(u_imm),
	.c(b_imm),
	.d(s_imm),
	.e(j_imm),
	.f(rs2_out),
	.g(32'hXXXXXXXX),
	.h(32'hXXXXXXXX),
	.out(alumux2_out)
);


/*REG MUX*/
mux16 regfilemux
(
	.sel(regfilemux_sel),
	.zero(alu_out),
	.one(zext_br_en),
	.two(u_imm),
	.three(mdrreg_out),
	.four(pc_plus4_out),
	.five(mdr_lh),
	.six(mdr_lhu),
	.seven(mdr_lb),
	.eight(mdr_lbu),
	.nine(32'hXXXXXXXX),
	.ten(32'hXXXXXXXX),
	.eleven(32'hXXXXXXXX),
	.twelve(32'hXXXXXXXX),
	.thirt(32'hXXXXXXXX),
	.fourte(32'hXXXXXXXX),
	.fift(32'hXXXXXXXX),
	.out(regfilemux_out)
);

/*ALU*/
alu alu_module
(
	.aluop,
	.a(alumux1_out),
	.b(alumux2_out),
	.f(alu_out)
);

/*CMP*/
cmp cmp_module
(
	.cmpop,
	.cmpmux_out(cmpmux_out),
	.rs1_out(rs1_out),
	.br_en(br_en)
);

/*PC*/
pc_register pc
(
    .clk,
    .load(load_pc),
    .in(pcmux_out),
    .out(pc_out)
);

/*IR*/
ir IR
(
	.clk,
	.load(load_ir),
	.in(mdrreg_out),
	.funct3,
	.funct7,
	.opcode,
	.i_imm,
	.s_imm,
	.b_imm,
	.u_imm,
	.j_imm,
	.rs1,
	.rs2,
	.rd
);

/*REG FILE*/
regfile regfile
(
	.clk,
	.load(load_regfile),
	.in(regfilemux_out),
	.src_a(rs1),
	.src_b(rs2),
	.dest(rd),
	.reg_a(rs1_out),
	.reg_b(rs2_out)
);

/*MDR*/
register mdrreg
(
	.clk,
	.load(load_mdr),
	.in(mem_rdata),
	.out(mdrreg_out)
);

/*MAR*/
register marreg
(
	.clk,
	.load(load_mar),
	.in(marmux_out),
	.out(mem_address)
);

/*MEM DATA OUT REG*/
register mem_data_out
(
	.clk,
	.load(load_data_out),
	.in(rs2_out),
	.out(mem_wdata)
);

endmodule : cpu_datapath
