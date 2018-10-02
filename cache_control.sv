import rv32i_types::*;

module cache_control
(
    input clk,

    /* Signals from CPU */
    input rv32i_mem_wmask mem_byte_enable,
    input mem_read,
    input mem_write,

    /* Signals from P-memory */
    input pmem_resp,

    /* Signals to P-memory */
    output logic pmem_read,
    output logic pmem_write,

    /* Signals to CPU */
    output logic mem_resp,

    /* Signal from Cache Datapath */
    input logic hit_0,
    input logic hit_1,
    input logic valid_out_0,
    input logic dirty_out_0,
    input logic valid_out_1,
    input logic dirty_out_1,

    input logic lru_out,

    /* Signal send to Cache Datapath */
    output logic load_data_0,
    output logic load_tag_0,
    output logic load_valid_0,
    output logic load_dirty_0,

    output logic load_data_1,
    output logic load_tag_1,
    output logic load_valid_1,
    output logic load_dirty_1,

    output logic valid_in,
    output logic dirty_in,
    output logic way_sel,

    output logic load_lru,
    output logic lru_in
    );

enum int unsigned {
    /* All the states, needs to be modified for the final CP */
    idle,
    read_write,
    access_pmem
} state, next_state;

always_comb
begin : state_actions
    /* Default output assignments */
    pmem_read = 1'b0;
    pmem_write = 1'b0;

    mem_resp = 1'b0;

    load_data_0 = 1'b0;
    load_tag_0 = 1'b0;
    load_valid_0 = 1'b0;
    load_dirty_0 = 1'b0;

    load_data_1 = 1'b0;
    load_tag_1 = 1'b0;
    load_valid_1 = 1'b0;
    load_dirty_1 = 1'b0;

    load_lru = 1'b0;
    way_sel = 1'b0;
    valid_in = 1'b0;
    dirty_in = 1'b0;
    lru_in = 1'b0;

    case(state)
        idle: // waiting for responses

        read_write: begin
            if (mem_read == 1)
                //read
                if (hit_0 == 1) begin
                    way_sel = 0;
                    mem_resp = 1;
                    lru_in = 1;
                    load_lru = 1;
                end

                else if (hit_1 == 1) begin
                    mem_resp = 1;
                    way_sel = 1;
                    lru_in = 0;
                    load_lru = 1;
                end

                else begin      // If we missed
                    mem_resp = 0;
                    way_sel = 0;
                    lru_in = 0;
                    load_lru = 0;
                end

            /* TODO: need update for write*/
            else begin
            end
        end

        access_pmem: begin
            pmem_read = 1;
            valid_in = 1;

            if (lru_out == 0) begin     // Accessing Cache Way 0
                load_data_0 = 1;
                load_tag_0 = 1;
                load_valid_0 = 1;
            end

            else if (lru_out == 1) begin     // Accessing Cache Way 1
                load_data_1 = 1;
                load_tag_1 = 1;
                load_valid_1 = 1;
            end

            else begin
            /* Do Nothing */
            end
        end

        /* Default state, in case accessing by mistake */
        default: ;
    endcase
end

always_comb
begin : next_state_logic
     next_state = state;

     case (state)
        idle: begin
            if (mem_read == 1 || mem_write == 1)
                next_state = read_write;
            else
                next_state = idle;
        end

        read_write: begin
            if (hit_0 == 1 || hit_1 == 1) // If there is a hit in Cache Way
                next_state = idle;

            else if (valid_out_0 == 1 && valid_out_1 == 1) /* If both ways are valid */
                // TODO: Need Update for Final CP
				next_state = access_pmem;	// Stay conflicted for now
            else
                next_state = access_pmem;
        end

        access_pmem: begin
            if (pmem_resp == 0) // If the memory is not ready, loop
                next_state = access_pmem;
            else
                next_state = read_write;
        end

        default: next_state = idle;
     endcase
end

always_ff @(posedge clk)
begin: next_state_assignment
    /* Assignment of next state on clock edge */
    state <= next_state;
end

endmodule : cache_control
