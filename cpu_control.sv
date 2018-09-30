import rv32i_types::*; /* Import types defined in rv32i_types.sv */

module cpu_control
(
     input clk,
	 /* From Datapath */
	 input br_en,
	 input rv32i_opcode opcode,
	 input [2:0] funct3,
	 input [6:0] funct7,

	 /* Datapath controls */
	 output logic load_pc,
	 output logic load_ir,
	 output logic load_regfile,
	 output logic load_mdr,
	 output logic load_mar,
	 output logic load_data_out,
	 output logic pcmux_sel,
	 output branch_funct3_t cmpop,
	 output logic alumux1_sel,
	 output logic [2:0] alumux2_sel,
	 output logic [3:0] regfilemux_sel,
	 output logic marmux_sel,
	 output logic cmpmux_sel,
	 output alu_ops aluop,
	 output logic jalr,

	 /* Memory signals */
	 input mem_resp,
	 output logic mem_read,
	 output logic mem_write,
	 output rv32i_mem_wmask mem_byte_enable
);

enum int unsigned {
	 /* List of states */
	 fetch1,
	 fetch2,
	 fetch3,
	 decode,
	 s_imm,
	 s_reg,	// added for mp2-cp1
	 br,
	 jal,	// added for mp2-cp1
	 s_jalr, 	// added for mp2-cp1
	 calc_addr,
	 ldr1,
	 ldr2,
	 str1,
	 str2,
	 s_lui,
	 s_auipc
} state, next_state;

always_comb
begin : state_actions
    /* Default output assignments */
	 load_pc = 1'b0;
	 load_ir = 1'b0;
	 load_regfile = 1'b0;
	 load_mar = 1'b0;
	 load_mdr = 1'b0;
	 load_data_out = 1'b0;
	 pcmux_sel = 0;
	 jalr = 1'b0;

	 //NOTE: need to take care of it in the future for SLTI and SLTIU
	 cmpop = branch_funct3_t'(funct3);
	 alumux1_sel = 1'b0;
	 alumux2_sel = 3'b000;
	 regfilemux_sel = 4'b0000;	// Always selecting alu output
	 marmux_sel = 1'b0;
	 cmpmux_sel = 1'b0;

	 //in many cases, aluop will be the same as funct3, so just typecast it
	 aluop = alu_ops'(funct3);
	 mem_read = 1'b0;
	 mem_write = 1'b0;
	 mem_byte_enable = 4'b1111;


    /* Actions for each state */
	 case(state)
		 fetch1: begin
			 /* MAR <= PC */
			 load_mar = 1;
		 end

		 fetch2: begin
			 /* Read memory */
			 mem_read = 1;
			 load_mdr = 1;
		 end

		 fetch3: begin
			 /* Load IR */
			 load_ir = 1;
		 end

		 decode: /* Do nothing */;

		 s_auipc: begin
			 /* DR <= PC + u_imm */
			 load_regfile = 1;

			 //PC is the first input to the ALU
			 alumux1_sel = 1;

			 //the u-type immediate is the second input to the ALU
			 alumux2_sel = 1;

			 //in the case of auipc, funct3 is some random bits so we
			 //must explicitly set the aluop
			 aluop = alu_add;

			 /* PC <= PC + 4 */
			 load_pc = 1;
		 end

		 s_imm: begin
			 // If this is the SLTI
			 if (funct3 == slt) begin
				 regfilemux_sel = 1;
				 load_regfile = 1;
				 cmpop = blt;
				 cmpmux_sel = 1;
				 load_pc = 1;
			 end

			 // If this is the SLTIU
			 else if (funct3 == sltu) begin
				 regfilemux_sel = 1;
				 load_regfile = 1;
				 cmpop = bltu;
				 cmpmux_sel = 1;
				 load_pc = 1;
			 end

			 // If this is SRAI
			 else if ((funct3 == sr) && (funct7 == 7'b0100000)) begin
				 load_regfile = 1;
				 aluop = alu_sra;
				 load_pc = 1;
			 end

			 else begin
				 load_regfile = 1;
				 aluop = alu_ops'(funct3);
				 load_pc = 1;
			 end
		 end

		 s_reg: begin
			 if (funct3 == slt) begin
				 regfilemux_sel = 1;
				 load_regfile = 1;
				 cmpop = blt;
				 // cmpmux_sel = 0;
				 load_pc = 1;
			 end
			 else if (funct3 == sltu) begin
				 regfilemux_sel = 1;
				 load_regfile = 1;
				 cmpop = bltu;
				 // cmpmux_sel = 1;
				 load_pc = 1;
			 end
			 else begin
				 load_regfile = 1;
				 alumux2_sel = 3'b101;
				 if ((funct3 == add) && (funct7 == 7'b0100000)) begin
					aluop = alu_sub;
				 end
				 else if ((funct3 == sr) && (funct7 == 7'b0100000)) begin
					 aluop = alu_sra;
				 end
				 else begin
					 aluop = alu_ops'(funct3);
				 end
				 load_pc = 1;
			 end
		 end

		 jal: begin
			 load_pc = 1;	// get pc+4
			 regfilemux_sel = 4'b0100;
			 load_regfile = 1;	// load rd with pc+4
			 alumux1_sel = 1;	// choose pc
			 alumux2_sel = 3'b100;	// choose j_imm
			 aluop = alu_add;
			 pcmux_sel = 1;
		 end

		 s_jalr: begin
			 load_pc = 1;	// get pc+4
			 regfilemux_sel = 4'b0100;
			 load_regfile = 1;	// load rd with pc+4
			 alumux1_sel = 0;	// choose rs1
			 alumux2_sel = 3'b000;	// choose i_imm
			 aluop = alu_add;
			 jalr = 1;
			 pcmux_sel = 1;
		 end

		 br: begin
			 alumux1_sel = 1;
			 alumux2_sel = 2;
			 aluop = alu_add;
			 pcmux_sel = br_en;
			 load_pc = 1;
		 end

		 calc_addr: begin
			 // if this is LW
			 if (opcode == op_load) begin
				 aluop = alu_add;
				 load_mar = 1;
				 marmux_sel = 1;
			 end

			 else if (opcode == op_store) begin
				 alumux2_sel = 3;
				 aluop = alu_add;
				 load_data_out = 1;
				 marmux_sel = 1;
				 load_mar = 1;
			 end
		 end

		 ldr1: begin
			 mem_read = 1;
			 load_mdr = 1;
		 end

		 ldr2: begin
			 if (funct3 == lw) begin
				 regfilemux_sel = 3;
			 end
			 else if (funct3 == lh) begin
				 regfilemux_sel = 5;
			 end
			 else if (funct3 == lhu) begin
				 regfilemux_sel = 6;
			 end
		  	 else if (funct3 == lb) begin
				 regfilemux_sel = 7;
			 end
			 else if (funct3 == lbu) begin
				 regfilemux_sel = 8;
			 end
			 else begin	// This case should never be reached
				 regfilemux_sel = 9;
			 end
			 load_regfile = 1;
			 load_pc = 1;
		 end

		 str1: begin
			 if (funct3 == sb)
				 mem_byte_enable = 4'b0001;
			 else if (funct3 == sh)
				 mem_byte_enable = 4'b0011;
			 else
				 mem_byte_enable = 4'b1111;
			 mem_write = 1;
		 end

		 str2: begin
			 load_pc = 1;
		 end

		 s_lui: begin
			 regfilemux_sel = 2;
			 load_regfile = 1;
			 load_pc = 1;
		 end

		 default: /* Do nothing */;
	 endcase
end

always_comb
begin : next_state_logic
    /* Next state information and conditions (if any)
     * for transitioning between states */
	 next_state = state;
	 case(state)
		 fetch1: next_state = fetch2;
		 fetch2: if (mem_resp) next_state = fetch3;
		 fetch3: next_state = decode;
		 decode: begin
			 case(opcode)
				 op_auipc: next_state = s_auipc;
				 op_imm: next_state = s_imm;
				 op_reg: next_state = s_reg;
				 op_lui: next_state = s_lui;
				 op_br: next_state = br;
				 op_load: next_state = calc_addr;
				 op_store: next_state = calc_addr;
				 op_jal: next_state = jal;
				 op_jalr: next_state = s_jalr;
				 default: $display("Unknown opcode");
			 endcase
		 end
		 calc_addr: begin
			 case(opcode)
				 op_load: next_state = ldr1;
				 op_store: next_state = str1;
				 default: $display("U retarded");
			 endcase
		 end
		 ldr1: if(mem_resp) next_state = ldr2;
		 ldr2: next_state = fetch1;
		 str1: if(mem_resp) next_state = str2;
		 str2: next_state = fetch1;
		 br: next_state = fetch1;
		 s_imm: next_state = fetch1;
		 s_lui: next_state = fetch1;
		 s_auipc: next_state = fetch1;

		 default: next_state = fetch1;
	 endcase
end

always_ff @(posedge clk)
begin: next_state_assignment
    /* Assignment of next state on clock edge */
	state <= next_state;
end

endmodule : control
