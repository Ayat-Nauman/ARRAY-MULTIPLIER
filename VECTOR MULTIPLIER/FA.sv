module FA (
input logic b,
input logic a,
input logic sum_ab,
input logic cin,
output logic cout,
output logic s
);

logic ab;
assign ab	= a & b;
assign s 	= sum_ab ^ ab ^ cin;
assign cout = (sum_ab & ab) | (sum_ab & cin) | (ab & cin);


endmodule
