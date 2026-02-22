module multiplier #(
    parameter N = 8
)(
    input  logic [N-1:0] a,
    input  logic [N-1:0] b,
    output logic [2*N-1:0] p
    );
    
    logic [N-1:0] sum   [N:0];
    logic [N:0]   carry;
    
    
    assign carry[0] = 1'b0;
    assign sum[0] = 0;
    genvar j;
    generate
        for (j = 0; j < N; j++) begin : ROWS
            CRA #(N) row (
                .a   (a),
                .b   (b[j]),
                .sum_ab  ({carry[j],sum[j][N-1:1]}),
                .cin (1'b0),
                .s   (sum[j+1]),
                .cout(carry[j+1])
            );
              assign p[j] = sum[j+1][0];
        end
    endgenerate
    
    assign p[2*N-1:N] = {carry[N], sum[N][N-1:1]};
    
endmodule