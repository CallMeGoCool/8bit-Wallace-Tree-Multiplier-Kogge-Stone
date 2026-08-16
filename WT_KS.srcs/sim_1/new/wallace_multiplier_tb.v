`timescale 1ns / 1ps

module wallace_multiplier_tb;

    reg  [7:0] A;
    reg  [7:0] B;

    wire [15:0] Sum_Row;
    wire [15:0] Carry_Row;

    wire [15:0] Wallace_Result;

    // ---------------------------------------------------------
    // Instantiate Wallace Tree
    // ---------------------------------------------------------

    wallace_multiplier DUT (
        .A(A),
        .B(B),
        .Sum_Row(Sum_Row),
        .Carry_Row(Carry_Row)
    );

    // ---------------------------------------------------------
    // The two Wallace rows should mathematically equal A × B
    // when added together.
    // ---------------------------------------------------------

    assign Wallace_Result = Sum_Row + Carry_Row;


    // ---------------------------------------------------------
    // Test procedure
    // ---------------------------------------------------------

    task check_result;
        input [7:0] test_A;
        input [7:0] test_B;

        reg [15:0] expected;

        begin

            A = test_A;
            B = test_B;

            #10;

            expected = test_A * test_B;

            if (Wallace_Result == expected)
                $display(
                    "PASS: A=%h B=%h -> Expected=%h Got=%h",
                    test_A,
                    test_B,
                    expected,
                    Wallace_Result
                );
            else
                $display(
                    "FAIL: A=%h B=%h -> Expected=%h Got=%h",
                    test_A,
                    test_B,
                    expected,
                    Wallace_Result
                );

        end
    endtask


    // ---------------------------------------------------------
    // Test Cases
    // ---------------------------------------------------------

    initial begin

        $display("==============================================");
        $display("       WALLACE TREE MULTIPLIER TESTBENCH");
        $display("==============================================");

        check_result(8'd0,   8'd0);
        check_result(8'd1,   8'd1);
        check_result(8'd2,   8'd3);
        check_result(8'd5,   8'd7);
        check_result(8'd10,  8'd25);
        check_result(8'd15,  8'd15);

        // Boundary / carry-heavy cases
        check_result(8'd127, 8'd2);
        check_result(8'd128, 8'd128);
        check_result(8'd200, 8'd3);

        // Maximum possible multiplication
        check_result(8'd255, 8'd255);

        // Additional patterns
        check_result(8'hAA, 8'h55);
        check_result(8'hFF, 8'h01);
        check_result(8'hF0, 8'h0F);

        $display("==============================================");
        $display("       WALLACE TREE TESTBENCH COMPLETED");
        $display("==============================================");

        $finish;

    end

endmodule