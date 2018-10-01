// A module for the simple comparator

module comparator (
    input [23:0] a,
    input [23:0] b,
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
