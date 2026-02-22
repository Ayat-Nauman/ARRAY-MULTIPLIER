module clk_mult #(
    parameter N = 8
)(
    input  logic clk,
    input  logic rst,
    input  logic [N-1:0] a,
    input  logic [N-1:0] b,
    output logic [2*N-1:0] buff_p
);

logic [N-1:0]   buff_a, buff_b;
wire [2*N-1:0] p;

// Combinational 
multiplier #(N) clk_mult (
    .a(buff_a),
    .b(buff_b),
    .p(p)
);

//Sequential
always_ff @(posedge clk) begin
    if (rst) begin // synchronous
        buff_a <= '0;
        buff_b <= '0;
        buff_p <= '0;
    end else begin
        buff_a <= a;
        buff_b <= b;
        buff_p <= p;
    end
end

endmodule