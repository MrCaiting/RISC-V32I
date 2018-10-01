module mux32 #(parameter width = 8)
(
    input logic [4:0] sel_in,
	input logic [width-1:0] a, b, c, d, e, f, g, h,
    input logic [width-1:0] i, j, k, l, m, n, o, p,
    input logic [width-1:0] a1, b1, c1, d1, e1, f1, g1, h1,
    input logic [width-1:0] i1, j1, k1, l1, m1, n1, o1, p1,
	output logic [width-1:0] out
);

logic leading_sel;
logic [width-1:0] first_mux_out;
logic [width-1:0] second_mux_out;
assign leading_sel = sel_in[4];

mux2  #(.width(8)) outer_mux
(
    .sel(leading_sel),
    .a(first_mux_out),
    .b(second_mux_out),
    .f(out)
    );

mux16 #(.width(8)) frist_8mux
(
	.sel(sel_in[3:0]),
	.zero(a),
	.one(b),
	.two(c),
	.three(d),
	.four(e),
	.five(f),
	.six(g),
	.seven(h),
	.eight(i),
	.nine(j),
	.ten(k),
	.eleven(l),
	.twelve(m),
	.thirt(n),
	.fourte(o),
	.fift(p),
	.out(first_mux_out)
    );

mux16 #(.width(8)) ssecond_8mux
(
	.sel(sel_in[3:0]),
	.zero(a1),
	.one(b1),
	.two(c1),
	.three(d1),
	.four(e1),
	.five(f1),
	.six(g1),
	.seven(h1),
	.eight(i1),
	.nine(j1),
	.ten(k1),
	.eleven(l1),
	.twelve(m1),
	.thirt(n1),
	.fourte(o1),
	.fift(p1),
	.out(second_mux_out)
    );

endmodule : mux32
