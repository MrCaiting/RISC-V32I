module mux16 #(parameter width = 32)
(
	 input [3:0] sel,
	 input [width-1:0] zero, one, two, three, four, five, six, seven,
	 input [width-1:0] eight, nine, ten, eleven, twelve, thirt, fourte, fift,
	 output logic [width-1:0] out
);

always_comb
begin
	if (sel == 4'b0000)	// 0
		 out = zero;
	else if (sel == 4'b0001)	// 1
		 out = one;
	else if (sel == 4'b0010)	// 2
		 out = two;
	else if (sel == 4'b0011)	// 3
		 out = three;
	else if (sel == 4'b0100)	// 4
		 out = four;
	else if (sel == 4'b0101)	// 5
		 out = five;
	else if (sel == 4'b0110)	// 6
		 out = six;
	else if (sel == 4'b0111)	// 7
		 out = seven;
	// separation line after a eight mux
	else if (sel == 4'b1000)	// 8
		 out = eight;
	else if (sel == 4'b1001)	// 9
		 out = nine;
	else if (sel == 4'b1010)	// 10
		 out = ten;
	else if (sel == 4'b1011)	// 11
		 out = eleven;
	else if (sel == 4'b1100)	// 12
		 out = twelve;
	else if (sel == 4'b1101)	// 13
		 out = thirt;
	else if (sel == 4'b0110)	// 14
		 out = fourte;
	else						// 15
		 out = fift;
end

endmodule: mux16