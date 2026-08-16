module wt_ks_top (
    input  wire [7:0]  A,
    input  wire [7:0]  B,
    output wire [15:0] Product
);

    // ---------------------------------------------------------
    // Wallace Tree Outputs
    // ---------------------------------------------------------

    wire [15:0] Sum_Row;
    wire [15:0] Carry_Row;

    // ---------------------------------------------------------
    // Wallace Tree
    // ---------------------------------------------------------

    wallace_multiplier WT (
        .A(A),
        .B(B),
        .Sum_Row(Sum_Row),
        .Carry_Row(Carry_Row)
    );

    // ---------------------------------------------------------
    // Kogge-Stone Final Adder
    // ---------------------------------------------------------

    wire [15:0] KS_Sum;
    wire        KS_Cout;

    kogge_stone_adder KS (
        .A(Sum_Row),
        .B(Carry_Row),
        .Cin(1'b0),
        .Sum(KS_Sum),
        .Cout(KS_Cout)
    );

    // ---------------------------------------------------------
    // Final Product
    // ---------------------------------------------------------

    assign Product = KS_Sum;

endmodule