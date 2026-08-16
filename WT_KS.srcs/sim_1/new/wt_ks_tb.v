`timescale 1ns / 1ps

module wt_ks_tb;

    reg  [7:0] A;
    reg  [7:0] B;

    wire [15:0] Product;

    // Variables for exhaustive verification
    integer i;
    integer j;
    integer error_count;

    // ---------------------------------------------------------
    // Instantiate Complete WT_KS Architecture
    // ---------------------------------------------------------

    wt_ks_top DUT (
        .A(A),
        .B(B),
        .Product(Product)
    );

    // ---------------------------------------------------------
    // Directed Test Task
    // ---------------------------------------------------------

    task check_result;

        input [7:0] test_A;
        input [7:0] test_B;

        reg [15:0] expected;

        begin

            A = test_A;
            B = test_B;

            #20;

            expected = test_A * test_B;

            if (Product == expected)
                $display(
                    "PASS: A=%h B=%h -> Expected=%h Got=%h",
                    test_A,
                    test_B,
                    expected,
                    Product
                );
            else
                $display(
                    "FAIL: A=%h B=%h -> Expected=%h Got=%h",
                    test_A,
                    test_B,
                    expected,
                    Product
                );

        end

    endtask


    // ---------------------------------------------------------
    // Test Procedure
    // ---------------------------------------------------------

    initial begin

        // =====================================================
        // DIRECTED TESTS
        // =====================================================

        $display("================================================");
        $display("       WT_KS MULTIPLIER TESTBENCH");
        $display("================================================");

        // Basic cases
        check_result(8'd0,   8'd0);
        check_result(8'd1,   8'd1);
        check_result(8'd2,   8'd3);
        check_result(8'd5,   8'd7);
        check_result(8'd10,  8'd25);
        check_result(8'd15,  8'd15);

        // Carry-heavy cases
        check_result(8'd31,  8'd17);
        check_result(8'd63,  8'd7);
        check_result(8'd127, 8'd2);
        check_result(8'd128, 8'd128);

        // Larger values
        check_result(8'd200, 8'd3);
        check_result(8'd170, 8'd85);

        // Boundary cases
        check_result(8'd255, 8'd1);
        check_result(8'd255, 8'd255);

        // Pattern tests
        check_result(8'hAA, 8'h55);
        check_result(8'hF0, 8'h0F);
        check_result(8'hFF, 8'hFF);


        // =====================================================
        // EXHAUSTIVE VERIFICATION
        // =====================================================

        $display("================================================");
        $display("       STARTING EXHAUSTIVE VERIFICATION");
        $display("       Total combinations: 65,536");
        $display("================================================");

        error_count = 0;

        // Test every possible combination of two 8-bit numbers
        for (i = 0; i < 256; i = i + 1) begin

            for (j = 0; j < 256; j = j + 1) begin

                A = i;
                B = j;

                // Allow combinational logic to settle
                #20;

                // Compare WT_KS result against behavioral multiplication
                if (Product !== (i * j)) begin

                    error_count = error_count + 1;

                    $display(
                        "ERROR: A=%h B=%h Expected=%h Got=%h",
                        i,
                        j,
                        (i * j),
                        Product
                    );

                end

            end

        end


        // =====================================================
        // EXHAUSTIVE VERIFICATION RESULT
        // =====================================================

        if (error_count == 0) begin

            $display("================================================");
            $display("EXHAUSTIVE VERIFICATION PASSED");
            $display("65,536 / 65,536 combinations verified");
            $display("================================================");

        end
        else begin

            $display("================================================");
            $display("EXHAUSTIVE VERIFICATION FAILED");
            $display("Number of errors = %0d", error_count);
            $display("================================================");

        end


        // =====================================================
        // TESTBENCH COMPLETED
        // =====================================================

        $display("================================================");
        $display("       WT_KS TESTBENCH COMPLETED");
        $display("================================================");

        $finish;

    end

endmodule