`timescale 1ns / 1ps

module kogge_stone_adder_tb;

    reg  [15:0] A;
    reg  [15:0] B;
    reg         Cin;

    wire [15:0] Sum;
    wire        Cout;

    // Instantiate the Kogge-Stone Adder
    kogge_stone_adder DUT (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );

    // Task for checking results
    task check_result;
        input [15:0] test_A;
        input [15:0] test_B;
        input        test_Cin;

        reg [16:0] expected;

        begin
            A = test_A;
            B = test_B;
            Cin = test_Cin;

            #10;

            expected = test_A + test_B + test_Cin;

            if ({Cout, Sum} == expected)
                $display(
                    "PASS: A=%h B=%h Cin=%b -> Result=%h",
                    test_A, test_B, test_Cin, {Cout, Sum}
                );
            else
                $display(
                    "FAIL: A=%h B=%h Cin=%b -> Expected=%h, Got=%h",
                    test_A, test_B, test_Cin, expected, {Cout, Sum}
                );
        end
    endtask

    initial begin

        $display("==============================================");
        $display("     KOGGE-STONE ADDER TESTBENCH");
        $display("==============================================");

        // Basic tests
        check_result(16'h0000, 16'h0000, 1'b0);
        check_result(16'h0001, 16'h0001, 1'b0);
        check_result(16'h0005, 16'h0007, 1'b0);
        check_result(16'h000F, 16'h0001, 1'b0);

        // Carry propagation tests
        check_result(16'h00FF, 16'h0001, 1'b0);
        check_result(16'h0FFF, 16'h0001, 1'b0);
        check_result(16'hFFFF, 16'h0001, 1'b0);

        // Large values
        check_result(16'hAAAA, 16'h5555, 1'b0);
        check_result(16'h8000, 16'h8000, 1'b0);
        check_result(16'hFFFF, 16'hFFFF, 1'b0);

        // Carry-in tests
        check_result(16'h0000, 16'h0000, 1'b1);
        check_result(16'hFFFF, 16'h0000, 1'b1);
        check_result(16'hFFFF, 16'hFFFF, 1'b1);

        $display("==============================================");
        $display("          TESTBENCH COMPLETED");
        $display("==============================================");

        $finish;
    end

endmodule