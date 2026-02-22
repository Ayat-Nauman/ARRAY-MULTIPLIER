`timescale 1ns/1ps

module multiplier_tb;

    parameter N = 8;

    logic [N-1:0] a, b;
    logic [2*N-1:0] p;
    logic [2*N-1:0] expected;

    integer pass_cnt = 0;
    integer fail_cnt = 0;

    // DUT
    multiplier #(N) dut (
        .a(a),
        .b(b),
        .p(p)
    );

    // Test sequence
    initial begin
    
        // Directed tests
        run_test(0, 0);
        run_test(1, 1);
        run_test(3, 5);
        run_test(15, 15);
        run_test(255, 1);
        run_test(255, 255);

        // Random tests
        repeat (100) begin
            run_test($urandom_range(0, 2**N-1),
                     $urandom_range(0, 2**N-1));
        end

        // Summary
        $display(" TEST SUMMARY ");
        $display(" PASS = %0d", pass_cnt);
        $display(" FAIL = %0d", fail_cnt);

        if (fail_cnt == 0)
            $display("ALL TESTS PASSED");
        else
            $display("TEST FAILED");

        $finish;
    end

    // Self-checking task
    task run_test(
        input logic [N-1:0] ta,
        input logic [N-1:0] tb
    );
    begin
        a = ta;
        b = tb;
        #1; // wait for combinational logic

        expected = ta * tb;

        if (p == expected) begin
            pass_cnt++;
   
            $display("PASS: a=%0d b=%0d p=%0d", ta, tb, p);
        end
        else begin
            fail_cnt++;
            $display("FAIL: a=%0d b=%0d | expected=%0d got=%0d",
                     ta, tb, expected, p);
        end
    end
    endtask
endmodule
