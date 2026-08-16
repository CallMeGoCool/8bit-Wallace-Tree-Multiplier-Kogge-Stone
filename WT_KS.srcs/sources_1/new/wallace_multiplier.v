module wallace_multiplier (
    input  wire [7:0]  A,
    input  wire [7:0]  B,

    output wire [15:0] Sum_Row,
    output wire [15:0] Carry_Row
);

    // ---------------------------------------------------------
    // Partial Products
    // ---------------------------------------------------------
    //
    // Each partial product is generated using bitwise AND.
    // The partial products are shifted according to the
    // corresponding bit position of B.
    //
    // 8-bit × 8-bit produces a maximum 16-bit result.
    // ---------------------------------------------------------

    wire [15:0] PP0;
    wire [15:0] PP1;
    wire [15:0] PP2;
    wire [15:0] PP3;
    wire [15:0] PP4;
    wire [15:0] PP5;
    wire [15:0] PP6;
    wire [15:0] PP7;

    assign PP0 = B[0] ? {8'b0, A}       : 16'b0;
    assign PP1 = B[1] ? ({8'b0, A} << 1) : 16'b0;
    assign PP2 = B[2] ? ({8'b0, A} << 2) : 16'b0;
    assign PP3 = B[3] ? ({8'b0, A} << 3) : 16'b0;
    assign PP4 = B[4] ? ({8'b0, A} << 4) : 16'b0;
    assign PP5 = B[5] ? ({8'b0, A} << 5) : 16'b0;
    assign PP6 = B[6] ? ({8'b0, A} << 6) : 16'b0;
    assign PP7 = B[7] ? ({8'b0, A} << 7) : 16'b0;


    // ---------------------------------------------------------
    // Wallace Tree Reduction
    // ---------------------------------------------------------
    //
    // A 3:2 compressor takes three input rows and reduces them
    // into two rows:
    //
    //     Sum   = X XOR Y XOR Z
    //     Carry = majority(X,Y,Z), shifted left by one bit
    //
    // This is equivalent to using a bank of Full Adders.
    // ---------------------------------------------------------


    // =========================
    // STAGE 1
    // =========================
    //
    // 8 rows → 6 rows
    //
    // Group 1:
    // PP0, PP1, PP2 → S1, C1
    //
    // Group 2:
    // PP3, PP4, PP5 → S2, C2
    //
    // PP6 and PP7 remain unchanged.

    wire [15:0] S1, C1;
    wire [15:0] S2, C2;

    assign S1 = PP0 ^ PP1 ^ PP2;
    assign C1 = ((PP0 & PP1) |
                 (PP0 & PP2) |
                 (PP1 & PP2)) << 1;

    assign S2 = PP3 ^ PP4 ^ PP5;
    assign C2 = ((PP3 & PP4) |
                 (PP3 & PP5) |
                 (PP4 & PP5)) << 1;


    // =========================
    // STAGE 2
    // =========================
    //
    // 6 rows → 4 rows
    //
    // Group 1:
    // S1, C1, S2 → S3, C3
    //
    // Group 2:
    // C2, PP6, PP7 → S4, C4

    wire [15:0] S3, C3;
    wire [15:0] S4, C4;

    assign S3 = S1 ^ C1 ^ S2;
    assign C3 = ((S1 & C1) |
                 (S1 & S2) |
                 (C1 & S2)) << 1;

    assign S4 = C2 ^ PP6 ^ PP7;
    assign C4 = ((C2 & PP6) |
                 (C2 & PP7) |
                 (PP6 & PP7)) << 1;


    // =========================
    // STAGE 3
    // =========================
    //
    // 4 rows → 3 rows
    //
    // Group:
    // S3, C3, S4 → S5, C5
    //
    // C4 remains.

    wire [15:0] S5, C5;

    assign S5 = S3 ^ C3 ^ S4;
    assign C5 = ((S3 & C3) |
                 (S3 & S4) |
                 (C3 & S4)) << 1;


    // =========================
    // STAGE 4
    // =========================
    //
    // 3 rows → 2 rows
    //
    // S5, C5, C4 → final Sum_Row, Carry_Row

    assign Sum_Row = S5 ^ C5 ^ C4;

    assign Carry_Row = ((S5 & C5) |
                        (S5 & C4) |
                        (C5 & C4)) << 1;

endmodule