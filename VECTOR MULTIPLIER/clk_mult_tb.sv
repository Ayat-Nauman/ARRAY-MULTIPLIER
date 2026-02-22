`timescale 1ns/1ps

module clk_mult_tb;

    parameter N = 8;

    logic clk;
    logic rst;
    logic [N-1:0] a, b;
    logic [2*N-1:0] p;

    logic [2*N-1:0] expected;
    integer pass_cnt = 0;
    integer fail_cnt = 0;

    // DUT
    clk_mult #(N) dut (
        .clk(clk),
        .rst(rst),
        .a(a),
        .b(b),
        .buff_p(p)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Test procedure
    initial begin
        clk = 0;
        rst = 1;
        a   = 0;
        b   = 0;

        // Apply reset
        #12;
        rst = 0;

        // Directed tests
        run_test(0, 0);
        run_test(3, 5);
        run_test(15, 15);
        run_test(255, 1);
        run_test(255, 255);

        // Random tests
        repeat (50) begin
            run_test($urandom_range(0, 2**N-1), $urandom_range(0, 2**N-1));
        end

        // Summary
        $display("\n===== TEST SUMMARY =====");
        $display("PASS = %0d", pass_cnt);
        $display("FAIL = %0d", fail_cnt);

        if (fail_cnt == 0)
            $display("ALL TESTS PASSED");
        else
            $display("TEST FAILED");

        $finish;
    end

    // Self-checking task (1-cycle latency)
    task run_test(
        input logic [N-1:0] ta,
        input logic [N-1:0] tb
    );
        logic [2*N-1:0] exp;
    begin
        a = ta;
        b = tb;
        exp = ta * tb;

        @(posedge clk); // input captured
        @(posedge clk); // output available
	@(posedge clk); // output available
        if (p == exp) begin
            pass_cnt++;
            $display("PASS: a=%0d b=%0d p=%0d exp = %0d", ta, tb, p, exp);
        end else begin
            fail_cnt++;
            $display("FAIL: a=%0d b=%0d | expected=%0d got=%0d",ta, tb, exp, p);
        end
    end
    endtask

endmodule