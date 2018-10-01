// A module for the simple comparator
import rv32i_types::*;

module comparator (
    input rv32i_cache_tag a,
    input rv32i_cache_tag b,
    input valid_bit,
    output logic equal
    );

    always_comb
    begin
        if (a == b)
            equal = valid_bit & valid_bit;
        else
            equal = 1'b0;
    end

endmodule : comparator
