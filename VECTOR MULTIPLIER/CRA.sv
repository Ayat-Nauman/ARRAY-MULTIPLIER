module CRA #(
    parameter N = 8
)(
    input  logic [N-1:0] a,     // multiplicand
    input  logic         b,     // one bit of multiplier
    input  logic [N-1:0] sum_ab,    // sum from previous row
    input  logic         cin,
    output logic [N-1:0] s,
    output logic         cout
);

    logic [N:0] c;
    assign c[0] = cin;
 

    genvar i;
    generate
        for (i = 0; i < N; i++) begin : FA_ROW
            FA fa (
                .a(a[i]),
                .b(b),
                .sum_ab(sum_ab[i]),
                .cin(c[i]),
                .s(s[i]),
                .cout(c[i+1])
            );
        end
    endgenerate

    assign cout = c[N];

endmodule
