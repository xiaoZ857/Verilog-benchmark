
module TopModule (
    input clk,
    input reset,
    input w,
    output reg [6:0] z
);

// Define the state table
localparam [1:0] states = 2'b00;
localparam [4:0] A = 2'b0000;
localparam [4:0] B = 2'b0010;
localparam [4:0] C = 2'b0100;
localparam [4:0] D = 2'b1000;
localparam [4:0] E = 2'b1100;
localparam [4:0] F = 2'b1110;

localparam NEXT_A = A;
localparam NEXT_B = B;
localparam NEXT_C = C;
localparam NEXT_D = D;
localparam NEXT_E = E;
localparam NEXT_F = F;

// State flip-flops
reg [1:0] state;

always @(*)
    case(state)
        states[1]: if(w == 1) state = A; else state = B;
        states[0]: if(w == 1) state = C; else state = D;
    endcase

// Output mapping
localparam [6:0] Z_A = {2'b00, A[3], A[2], A[1], A[0]};
localparam [6:0] Z_B = {2'b01, B[3], B[2], B[1], B[0]};
localparam [6:0] Z_C = {2'b10, C[3], C[2], C[1], C[0]};
localparam [6:0] Z_D = {2'b11, D[3], D[2], D[1], D[0]};
localparam [6:0] Z_E = {4'b0111, E[2], E[1], E[0]};
localparam [6:0] Z_F = {5'b11010, F[1], F[0]};

always @(*)
    case(state)
        states: z <= Z_A;
        A: if(w == 1) z <= Z_B; else z <= Z_A;
        C: if(w == 1) z <= Z_F; else z <= Z_C;
        D: if(w == 1) z <= Z_E; else z <= Z_D;
    endcase

// Reset logic
always @(posedge clk)
    if(reset) 
        state <= states;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
