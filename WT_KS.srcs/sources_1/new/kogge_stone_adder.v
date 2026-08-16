module kogge_stone_adder (
    input  wire [15:0] A,
    input  wire [15:0] B,
    input  wire        Cin,
    output wire [15:0] Sum,
    output wire        Cout
);

    // Generate and Propagate signals
    wire [15:0] G;
    wire [15:0] P;

    // Prefix levels
    wire [15:0] G1, P1;
    wire [15:0] G2, P2;
    wire [15:0] G3, P3;
    wire [15:0] G4, P4;

    // Carry signals
    wire [16:0] C;

    // ---------------------------------------------------------
    // Initial Generate and Propagate
    // G = A AND B
    // P = A XOR B
    // ---------------------------------------------------------
    assign G = A & B;
    assign P = A ^ B;

    // ---------------------------------------------------------
    // Prefix Level 1 - Distance = 1
    // ---------------------------------------------------------
    assign G1[0] = G[0];
    assign P1[0] = P[0];

    genvar i;

    generate
        for (i = 1; i < 16; i = i + 1) begin : LEVEL1
            assign G1[i] = G[i] | (P[i] & G[i-1]);
            assign P1[i] = P[i] & P[i-1];
        end
    endgenerate

    // ---------------------------------------------------------
    // Prefix Level 2 - Distance = 2
    // ---------------------------------------------------------
    assign G2[1:0] = G1[1:0];
    assign P2[1:0] = P1[1:0];

    generate
        for (i = 2; i < 16; i = i + 1) begin : LEVEL2
            assign G2[i] = G1[i] | (P1[i] & G1[i-2]);
            assign P2[i] = P1[i] & P1[i-2];
        end
    endgenerate

    // ---------------------------------------------------------
    // Prefix Level 3 - Distance = 4
    // ---------------------------------------------------------
    assign G3[3:0] = G2[3:0];
    assign P3[3:0] = P2[3:0];

    generate
        for (i = 4; i < 16; i = i + 1) begin : LEVEL3
            assign G3[i] = G2[i] | (P2[i] & G2[i-4]);
            assign P3[i] = P2[i] & P2[i-4];
        end
    endgenerate

    // ---------------------------------------------------------
    // Prefix Level 4 - Distance = 8
    // ---------------------------------------------------------
    assign G4[7:0] = G3[7:0];
    assign P4[7:0] = P3[7:0];

    generate
        for (i = 8; i < 16; i = i + 1) begin : LEVEL4
            assign G4[i] = G3[i] | (P3[i] & G3[i-8]);
            assign P4[i] = P3[i] & P3[i-8];
        end
    endgenerate

    // ---------------------------------------------------------
    // Carry Generation
    //
    // C[0] is the input carry.
    // For each bit:
    // C[i+1] = G[i] | (P[i] & C[i])
    // ---------------------------------------------------------

    assign C[0] = Cin;

    assign C[1]  = G4[0] | (P4[0] & Cin);
    assign C[2]  = G4[1] | (P4[1] & Cin);
    assign C[3]  = G4[2] | (P4[2] & Cin);
    assign C[4]  = G4[3] | (P4[3] & Cin);
    assign C[5]  = G4[4] | (P4[4] & Cin);
    assign C[6]  = G4[5] | (P4[5] & Cin);
    assign C[7]  = G4[6] | (P4[6] & Cin);
    assign C[8]  = G4[7] | (P4[7] & Cin);
    assign C[9]  = G4[8] | (P4[8] & Cin);
    assign C[10] = G4[9] | (P4[9] & Cin);
    assign C[11] = G4[10] | (P4[10] & Cin);
    assign C[12] = G4[11] | (P4[11] & Cin);
    assign C[13] = G4[12] | (P4[12] & Cin);
    assign C[14] = G4[13] | (P4[13] & Cin);
    assign C[15] = G4[14] | (P4[14] & Cin);
    assign C[16] = G4[15] | (P4[15] & Cin);

    // ---------------------------------------------------------
    // Sum Generation
    // ---------------------------------------------------------
    assign Sum = P ^ C[15:0];

    // Final carry
    assign Cout = C[16];

endmodule