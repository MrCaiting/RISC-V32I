import rv32i_types::*;

module write_cache
(
  input rv32i_mem_wmask mem_byte_enable,
  input rv32i_word mem_wdata,
  input logic [4:0] byte_offset,
  input logic [255:0] cache_mux_out,
  output logic [255:0] write_cache_out
  );

// assign write_cache_out = cache_mux_out;

logic [7:0] byte0, byte1, byte2, byte3;


always_comb
begin
	if (byte_offset == 5'b00000) begin   // Offset = 0
        if (mem_byte_enable[0])
            byte0 = mem_wdata[7:0];
        else
            byte0 = cache_mux_out[7:0];

        if (mem_byte_enable[1])
            byte1 = mem_wdata[15:8];
        else
            byte1 = cache_mux_out[15:8];

        if (mem_byte_enable[2])
            byte2 = mem_wdata[23:16];
        else
            byte2 = cache_mux_out[23:16];

        if (mem_byte_enable[3])
            byte3 = mem_wdata[31:24];
        else
            byte3 = cache_mux_out[31:24];

        write_cache_out = {cache_mux_out[255:32], byte3, byte2, byte1, byte0};
    end

    else if (byte_offset == 5'b00001) begin   // Offset = 1
        if (mem_byte_enable[0])
            byte0 = mem_wdata[7:0];
        else
            byte0 = cache_mux_out[15:8];

        if (mem_byte_enable[1])
            byte1 = mem_wdata[15:8];
        else
            byte1 = cache_mux_out[23:16];

        if (mem_byte_enable[2])
            byte2 = mem_wdata[23:16];
        else
            byte2 = cache_mux_out[31:24];

        if (mem_byte_enable[3])
            byte3 = mem_wdata[31:24];
        else
            byte3 = cache_mux_out[39:32];

        write_cache_out = {cache_mux_out[255:40], byte3, byte2, byte1, byte0, cache_mux_out[7:0]};
    end

    else if (byte_offset == 5'b00010) begin   // Offset = 2
        if (mem_byte_enable[0])
            byte0 = mem_wdata[7:0];
        else
            byte0 = cache_mux_out[23:16];

        if (mem_byte_enable[1])
            byte1 = mem_wdata[15:8];
        else
            byte1 = cache_mux_out[31:24];

        if (mem_byte_enable[2])
            byte2 = mem_wdata[23:16];
        else
            byte2 = cache_mux_out[39:32];

        if (mem_byte_enable[3])
            byte3 = mem_wdata[31:24];
        else
            byte3 = cache_mux_out[47:40];

        write_cache_out = {cache_mux_out[255:48], byte3, byte2, byte1, byte0, cache_mux_out[15:0]};
    end

    else if (byte_offset == 5'b00011) begin   // Offset = 3
        if (mem_byte_enable[0])
            byte0 = mem_wdata[7:0];
        else
            byte0 = cache_mux_out[31:24];

        if (mem_byte_enable[1])
            byte1 = mem_wdata[15:8];
        else
            byte1 = cache_mux_out[39:32];

        if (mem_byte_enable[2])
            byte2 = mem_wdata[23:16];
        else
            byte2 = cache_mux_out[47:40];

        if (mem_byte_enable[3])
            byte3 = mem_wdata[31:24];
        else
            byte3 = cache_mux_out[55:48];

        write_cache_out = {cache_mux_out[255:56], byte3, byte2, byte1, byte0, cache_mux_out[23:0]};
    end

    else if (byte_offset == 5'b00100) begin   // Offset = 4
        if (mem_byte_enable[0])
            byte0 = mem_wdata[7:0];
        else
            byte0 = cache_mux_out[39:32];

        if (mem_byte_enable[1])
            byte1 = mem_wdata[15:8];
        else
            byte1 = cache_mux_out[47:40];

        if (mem_byte_enable[2])
            byte2 = mem_wdata[23:16];
        else
            byte2 = cache_mux_out[55:48];

        if (mem_byte_enable[3])
            byte3 = mem_wdata[31:24];
        else
            byte3 = cache_mux_out[63:56];

        write_cache_out = {cache_mux_out[255:64], byte3, byte2, byte1, byte0, cache_mux_out[31:0]};
    end

    else if (byte_offset == 5'b00101) begin   // Offset = 5
        if (mem_byte_enable[0])
            byte0 = mem_wdata[7:0];
        else
            byte0 = cache_mux_out[47:40];

        if (mem_byte_enable[1])
            byte1 = mem_wdata[15:8];
        else
            byte1 = cache_mux_out[55:48];

        if (mem_byte_enable[2])
            byte2 = mem_wdata[23:16];
        else
            byte2 = cache_mux_out[63:56];

        if (mem_byte_enable[3])
            byte3 = mem_wdata[31:24];
        else
            byte3 = cache_mux_out[71:64];

        write_cache_out = {cache_mux_out[255:72], byte3, byte2, byte1, byte0, cache_mux_out[39:0]};
    end

    else if (byte_offset == 5'b00110) begin   // Offset = 6
        if (mem_byte_enable[0])
            byte0 = mem_wdata[7:0];
        else
            byte0 = cache_mux_out[55:48];

        if (mem_byte_enable[1])
            byte1 = mem_wdata[15:8];
        else
            byte1 = cache_mux_out[63:56];

        if (mem_byte_enable[2])
            byte2 = mem_wdata[23:16];
        else
            byte2 = cache_mux_out[71:64];

        if (mem_byte_enable[3])
            byte3 = mem_wdata[31:24];
        else
            byte3 = cache_mux_out[79:72];

        write_cache_out = {cache_mux_out[255:80], byte3, byte2, byte1, byte0, cache_mux_out[47:0]};
    end

    else if (byte_offset == 5'b00111) begin   // Offset = 7
        if (mem_byte_enable[0])
            byte0 = mem_wdata[7:0];
        else
            byte0 = cache_mux_out[63:56];

        if (mem_byte_enable[1])
            byte1 = mem_wdata[15:8];
        else
            byte1 = cache_mux_out[71:64];

        if (mem_byte_enable[2])
            byte2 = mem_wdata[23:16];
        else
            byte2 = cache_mux_out[79:72];

        if (mem_byte_enable[3])
            byte3 = mem_wdata[31:24];
        else
            byte3 = cache_mux_out[87:80];

        write_cache_out = {cache_mux_out[255:88], byte3, byte2, byte1, byte0, cache_mux_out[55:0]};
    end

    else if (byte_offset == 5'b01000) begin   // Offset = 8
        if (mem_byte_enable[0])
            byte0 = mem_wdata[7:0];
        else
            byte0 = cache_mux_out[71:64];

        if (mem_byte_enable[1])
            byte1 = mem_wdata[15:8];
        else
            byte1 = cache_mux_out[79:72];

        if (mem_byte_enable[2])
            byte2 = mem_wdata[23:16];
        else
            byte2 = cache_mux_out[87:80];

        if (mem_byte_enable[3])
            byte3 = mem_wdata[31:24];
        else
            byte3 = cache_mux_out[95:88];

        write_cache_out = {cache_mux_out[255:96], byte3, byte2, byte1, byte0, cache_mux_out[63:0]};
    end

    else if (byte_offset == 5'b01001) begin   // Offset = 9
        if (mem_byte_enable[0])
            byte0 = mem_wdata[7:0];
        else
            byte0 = cache_mux_out[79:72];

        if (mem_byte_enable[1])
            byte1 = mem_wdata[15:8];
        else
            byte1 = cache_mux_out[87:80];

        if (mem_byte_enable[2])
            byte2 = mem_wdata[23:16];
        else
            byte2 = cache_mux_out[95:88];

        if (mem_byte_enable[3])
            byte3 = mem_wdata[31:24];
        else
            byte3 = cache_mux_out[103:96];

        write_cache_out = {cache_mux_out[255:104], byte3, byte2, byte1, byte0, cache_mux_out[71:0]};
    end

    else if (byte_offset == 5'b01010) begin   // Offset = 10
        if (mem_byte_enable[0])
            byte0 = mem_wdata[7:0];
        else
            byte0 = cache_mux_out[87:80];

        if (mem_byte_enable[1])
            byte1 = mem_wdata[15:8];
        else
            byte1 = cache_mux_out[95:88];

        if (mem_byte_enable[2])
            byte2 = mem_wdata[23:16];
        else
            byte2 = cache_mux_out[103:96];

        if (mem_byte_enable[3])
            byte3 = mem_wdata[31:24];
        else
            byte3 = cache_mux_out[111:104];

        write_cache_out = {cache_mux_out[255:112], byte3, byte2, byte1, byte0, cache_mux_out[79:0]};
    end

    else if (byte_offset == 5'b01011) begin   // Offset = 11
        if (mem_byte_enable[0])
            byte0 = mem_wdata[7:0];
        else
            byte0 = cache_mux_out[95:88];

        if (mem_byte_enable[1])
            byte1 = mem_wdata[15:8];
        else
            byte1 = cache_mux_out[103:96];

        if (mem_byte_enable[2])
            byte2 = mem_wdata[23:16];
        else
            byte2 = cache_mux_out[111:104];

        if (mem_byte_enable[3])
            byte3 = mem_wdata[31:24];
        else
            byte3 = cache_mux_out[119:112];

        write_cache_out = {cache_mux_out[255:120], byte3, byte2, byte1, byte0, cache_mux_out[87:0]};
    end

    else if (byte_offset == 5'b01100) begin   // Offset = 12
        if (mem_byte_enable[0])
            byte0 = mem_wdata[7:0];
        else
            byte0 = cache_mux_out[103:96];

        if (mem_byte_enable[1])
            byte1 = mem_wdata[15:8];
        else
            byte1 = cache_mux_out[111:104];

        if (mem_byte_enable[2])
            byte2 = mem_wdata[23:16];
        else
            byte2 = cache_mux_out[119:112];

        if (mem_byte_enable[3])
            byte3 = mem_wdata[31:24];
        else
            byte3 = cache_mux_out [127:120];

        write_cache_out = {cache_mux_out[255:128], byte3, byte2, byte1, byte0, cache_mux_out[95:0]};
    end

    else if (byte_offset == 5'b01101) begin   // Offset = 13
        if (mem_byte_enable[0])
            byte0 = mem_wdata[7:0];
        else
            byte0 = cache_mux_out[111:104];

        if (mem_byte_enable[1])
            byte1 = mem_wdata[15:8];
        else
            byte1 = cache_mux_out[119:112];

        if (mem_byte_enable[2])
            byte2 = mem_wdata[23:16];
        else
            byte2 = cache_mux_out[127:120];

        if (mem_byte_enable[3])
            byte3 = mem_wdata[31:24];
        else
            byte3 = cache_mux_out[135:128];

        write_cache_out = {cache_mux_out[255:136], byte3, byte2, byte1, byte0, cache_mux_out[103:0]};
    end

    else if (byte_offset == 5'b01110) begin   // Offset = 14
        if (mem_byte_enable[0])
            byte0 = mem_wdata[7:0];
        else
            byte0 = cache_mux_out[119:112];

        if (mem_byte_enable[1])
            byte1 = mem_wdata[15:8];
        else
            byte1 = cache_mux_out[127:120];

        if (mem_byte_enable[2])
            byte2 = mem_wdata[23:16];
        else
            byte2 = cache_mux_out[135:128];

        if (mem_byte_enable[3])
            byte3 = mem_wdata[31:24];
        else
            byte3 = cache_mux_out[143:136];

        write_cache_out = {cache_mux_out[255:144], byte3, byte2, byte1, byte0, cache_mux_out[111:0]};
    end

    else if (byte_offset == 5'b01111) begin   // Offset = 15
        if (mem_byte_enable[0])
            byte0 = mem_wdata[7:0];
        else
            byte0 = cache_mux_out[127:120];

        if (mem_byte_enable[1])
            byte1 = mem_wdata[15:8];
        else
            byte1 = cache_mux_out[135:128];

        if (mem_byte_enable[2])
            byte2 = mem_wdata[23:16];
        else
            byte2 = cache_mux_out[143:136];

        if (mem_byte_enable[3])
            byte3 = mem_wdata[31:24];
        else
            byte3 = cache_mux_out[151:144];

        write_cache_out = {cache_mux_out[255:152], byte3, byte2, byte1, byte0, cache_mux_out[119:0]};
    end

    else if (byte_offset == 5'b10000) begin   // Offset = 16
        if (mem_byte_enable[0])
            byte0 = mem_wdata[7:0];
        else
            byte0 = cache_mux_out[135:128];

        if (mem_byte_enable[1])
            byte1 = mem_wdata[15:8];
        else
            byte1 = cache_mux_out[143:136];

        if (mem_byte_enable[2])
            byte2 = mem_wdata[23:16];
        else
            byte2 = cache_mux_out[151:144];

        if (mem_byte_enable[3])
            byte3 = mem_wdata[31:24];
        else
            byte3 = cache_mux_out[159:152];

        write_cache_out = {cache_mux_out[255:160], byte3, byte2, byte1, byte0, cache_mux_out[127:0]};
    end

    else if (byte_offset == 5'b10001) begin   // Offset = 17
        if (mem_byte_enable[0])
            byte0 = mem_wdata[7:0];
        else
            byte0 = cache_mux_out[143:136];

        if (mem_byte_enable[1])
            byte1 = mem_wdata[15:8];
        else
            byte1 = cache_mux_out[151:144];

        if (mem_byte_enable[2])
            byte2 = mem_wdata[23:16];
        else
            byte2 = cache_mux_out[159:152];

        if (mem_byte_enable[3])
            byte3 = mem_wdata[31:24];
        else
            byte3 = cache_mux_out[167:160];

        write_cache_out = {cache_mux_out[255:168], byte3, byte2, byte1, byte0, cache_mux_out[135:0]};
    end

    else if (byte_offset == 5'b10010) begin   // Offset = 18
        if (mem_byte_enable[0])
            byte0 = mem_wdata[7:0];
        else
            byte0 = cache_mux_out[151:144];

        if (mem_byte_enable[1])
            byte1 = mem_wdata[15:8];
        else
            byte1 = cache_mux_out[159:152];

        if (mem_byte_enable[2])
            byte2 = mem_wdata[23:16];
        else
            byte2 = cache_mux_out[167:160];

        if (mem_byte_enable[3])
            byte3 = mem_wdata[31:24];
        else
            byte3 = cache_mux_out[175:168];

        write_cache_out = {cache_mux_out[255:176], byte3, byte2, byte1, byte0, cache_mux_out[143:0]};
    end

    else if (byte_offset == 5'b10011) begin   // Offset = 19
        if (mem_byte_enable[0])
            byte0 = mem_wdata[7:0];
        else
            byte0 = cache_mux_out[159:152];

        if (mem_byte_enable[1])
            byte1 = mem_wdata[15:8];
        else
            byte1 = cache_mux_out[167:160];

        if (mem_byte_enable[2])
            byte2 = mem_wdata[23:16];
        else
            byte2 = cache_mux_out[175:168];

        if (mem_byte_enable[3])
            byte3 = mem_wdata[31:24];
        else
            byte3 = cache_mux_out[183:176];

        write_cache_out = {cache_mux_out[255:184], byte3, byte2, byte1, byte0, cache_mux_out[151:0]};
    end

    else if (byte_offset == 5'b10100) begin   // Offset = 20
        if (mem_byte_enable[0])
            byte0 = mem_wdata[7:0];
        else
            byte0 = cache_mux_out[167:160];

        if (mem_byte_enable[1])
            byte1 = mem_wdata[15:8];
        else
            byte1 = cache_mux_out[175:168];

        if (mem_byte_enable[2])
            byte2 = mem_wdata[23:16];
        else
            byte2 = cache_mux_out[183:176];

        if (mem_byte_enable[3])
            byte3 = mem_wdata[31:24];
        else
            byte3 = cache_mux_out[191:184];

        write_cache_out = {cache_mux_out[255:192], byte3, byte2, byte1, byte0, cache_mux_out[159:0]};
    end

    else if (byte_offset == 5'b10101) begin   // Offset = 21
        if (mem_byte_enable[0])
            byte0 = mem_wdata[7:0];
        else
            byte0 = cache_mux_out[175:168];

        if (mem_byte_enable[1])
            byte1 = mem_wdata[15:8];
        else
            byte1 = cache_mux_out[183:176];

        if (mem_byte_enable[2])
            byte2 = mem_wdata[23:16];
        else
            byte2 = cache_mux_out[191:184];

        if (mem_byte_enable[3])
            byte3 = mem_wdata[31:24];
        else
            byte3 = cache_mux_out[199:192];

        write_cache_out = {cache_mux_out[255:200], byte3, byte2, byte1, byte0, cache_mux_out[167:0]};
    end

    else if (byte_offset == 5'b10110) begin   // Offset = 22
        if (mem_byte_enable[0])
            byte0 = mem_wdata[7:0];
        else
            byte0 = cache_mux_out[183:176];

        if (mem_byte_enable[1])
            byte1 = mem_wdata[15:8];
        else
            byte1 = cache_mux_out[191:184];

        if (mem_byte_enable[2])
            byte2 = mem_wdata[23:16];
        else
            byte2 = cache_mux_out[199:192];

        if (mem_byte_enable[3])
            byte3 = mem_wdata[31:24];
        else
            byte3 = cache_mux_out[207:200];

        write_cache_out = {cache_mux_out[255:208], byte3, byte2, byte1, byte0, cache_mux_out[175:0]};
    end

    else if (byte_offset == 5'b10111) begin   // Offset = 23
        if (mem_byte_enable[0])
            byte0 = mem_wdata[7:0];
        else
            byte0 = cache_mux_out[191:184];

        if (mem_byte_enable[1])
            byte1 = mem_wdata[15:8];
        else
            byte1 = cache_mux_out[199:192];

        if (mem_byte_enable[2])
            byte2 = mem_wdata[23:16];
        else
            byte2 = cache_mux_out[207:200];

        if (mem_byte_enable[3])
            byte3 = mem_wdata[31:24];
        else
            byte3 = cache_mux_out[215:208];

        write_cache_out = {cache_mux_out[255:216], byte3, byte2, byte1, byte0, cache_mux_out[183:0]};
    end

    else if (byte_offset == 5'b11000) begin   // Offset = 24
        if (mem_byte_enable[0])
            byte0 = mem_wdata[7:0];
        else
            byte0 = cache_mux_out[199:192];

        if (mem_byte_enable[1])
            byte1 = mem_wdata[15:8];
        else
            byte1 = cache_mux_out[207:200];

        if (mem_byte_enable[2])
            byte2 = mem_wdata[23:16];
        else
            byte2 = cache_mux_out[215:208];

        if (mem_byte_enable[3])
            byte3  = mem_wdata[31:24];
        else
            byte3 = cache_mux_out[223:216];

        write_cache_out = {cache_mux_out[255:224], byte3, byte2, byte1, byte0, cache_mux_out[191:0]};
    end

    else if (byte_offset == 5'b11001) begin   // Offset = 25
        if (mem_byte_enable[0])
            byte0 = mem_wdata[7:0];
        else
            byte0 = cache_mux_out[207:200];

        if (mem_byte_enable[1])
            byte1 = mem_wdata[15:8];
        else
            byte1 = cache_mux_out[215:208];

        if (mem_byte_enable[2])
            byte2 = mem_wdata[23:16];
        else
            byte2 = cache_mux_out[223:216];

        if (mem_byte_enable[3])
            byte3 = mem_wdata[31:24];
        else
            byte3 = cache_mux_out[231:224];

        write_cache_out = {cache_mux_out[255:232], byte3, byte2, byte1, byte0, cache_mux_out[199:0]};
    end

    else if (byte_offset == 5'b11010) begin   // Offset = 26
        if (mem_byte_enable[0])
            byte0 = mem_wdata[7:0];
        else
            byte0 = cache_mux_out[215:208];

        if (mem_byte_enable[1])
            byte1 = mem_wdata[15:8];
        else
            byte1 = cache_mux_out[223:216];

        if (mem_byte_enable[2])
            byte2 = mem_wdata[23:16];
        else
            byte2 = cache_mux_out[231:224];

        if (mem_byte_enable[3])
            byte3 = mem_wdata[31:24];
        else
            byte3 = cache_mux_out[239:232];

        write_cache_out = {cache_mux_out[255:240], byte3, byte2, byte1, byte0, cache_mux_out[207:0]};
    end

    else if (byte_offset == 5'b11011) begin   // Offset = 27
        if (mem_byte_enable[0])
            byte0 = mem_wdata[7:0];
        else
            byte0 = cache_mux_out[223:216];

        if (mem_byte_enable[1])
            byte1 = mem_wdata[15:8];
        else
            byte1 = cache_mux_out[231:224];

        if (mem_byte_enable[2])
            byte2 = mem_wdata[23:16];
        else
            byte2 = cache_mux_out[239:232];

        if (mem_byte_enable[3])
            byte3 = mem_wdata[31:24];
        else
            byte3 = cache_mux_out[247:240];

        write_cache_out = {cache_mux_out[255:248], byte3, byte2, byte1, byte0, cache_mux_out[215:0]};
    end

    else if (byte_offset == 5'b11100) begin   // Offset = 28
        if (mem_byte_enable[0])
            byte0 = mem_wdata[7:0];
        else
            byte0 = cache_mux_out[231:224];

        if (mem_byte_enable[1])
            byte1 = mem_wdata[15:8];
        else
            byte1 = cache_mux_out[239:232];

        if (mem_byte_enable[2])
            byte2 = mem_wdata[23:16];
        else
            byte2 = cache_mux_out[247:240];

        if (mem_byte_enable[3])
            byte3 = mem_wdata[31:24];
        else
            byte3 = cache_mux_out[255:248];

        write_cache_out = {byte3, byte2, byte1, byte0, cache_mux_out[223:0]};
    end

    else if (byte_offset == 5'b11101) begin   // Offset = 29
        if (mem_byte_enable[0])
            byte0 = mem_wdata[7:0];
        else
            byte0 = cache_mux_out[239:232];

        if (mem_byte_enable[1])
            byte1 = mem_wdata[15:8];
        else
            byte1 = cache_mux_out[247:240];

        if (mem_byte_enable[2])  // Should not be here
            ;
        if (mem_byte_enable[3])  // Should not be here
            ;
        byte2 = 8'hXX;
        byte3 = 8'hXX;

        write_cache_out = {cache_mux_out[255:248], byte1, byte0, cache_mux_out[231:0]};
    end

    else if (byte_offset == 5'b11110) begin   // Offset = 30
        if (mem_byte_enable[0])
            byte0 = mem_wdata[7:0];
        else
            byte0 = cache_mux_out[247:240];

        if (mem_byte_enable[1])
            byte1 = mem_wdata[15:8];
        else
            byte1 = cache_mux_out[255:248];

        if (mem_byte_enable[2])  // Should not be here
            ;
        if (mem_byte_enable[3])  // Should not be here
            ;

        byte2 = 8'hXX;
        byte3 = 8'hXX;
        write_cache_out = {byte1, byte0, cache_mux_out[239:0]};
    end

    else if (byte_offset == 5'b11111) begin   // Offset = 31
        if (mem_byte_enable[0])
            byte0 = mem_wdata[7:0];
        else
            byte0 = cache_mux_out[255:248];

        if (mem_byte_enable[1])  // Should not be here
            ;
        if (mem_byte_enable[2])  // Should not be here
            ;
        if (mem_byte_enable[3])  // Should not be here
            ;
            
        byte1 = 8'hXX;
        byte2 = 8'hXX;
        byte3 = 8'hXX;
        write_cache_out = {byte0, cache_mux_out[247:0]};
    end

    else begin  // default case
        write_cache_out = cache_mux_out;
        byte0 = 8'hXX;
        byte1 = 8'hXX;
        byte2 = 8'hXX;
        byte3 = 8'hXX;
    end
end

endmodule : write_cache
