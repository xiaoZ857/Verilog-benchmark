
module TopModule (
    input clk,
    input reset,
    input w,
    output reg [6:0] z
);

// State flip-flops
reg [1:0] state;

always @(*)
    case(state)
        2'b00: if(w == 1) state = 2'b01; else state = 2'b00;
        2'b00: if(w == 0) state = 2'b00;
        2'b01: if(w == 1) state = 2'b10; else state = 2'b01;
    endcase

// Output mapping
reg [6:0] z_prev;

always @(*)
    case(state)
        2'b00: z_prev = {4'b0000, A[3], A[2], A[1]};
        2'b01: z_prev = {4'b0010, B[3], B[2], B[1]};
        2'b10: z_prev = {4'b0100, C[3], C[2], C[1]};
    endcase

always @(*)
    case(state)
        2'b00: if(w == 1) z <= Z_B; else z <= z_prev;
        2'b01: if(w == 1) z <= Z_C; else z <= z_prev;
        2'b10: if(w == 1) z <= Z_E; else z <= z_prev;
    endcase

// Reset logic
always @(posedge clk)
    if(reset) 
        state <= 2'b00;

// Next states
reg [4:0] A, B, C, D, E, F;

localparam A = {3'b000, w}, B = {3'b001, w};
localparam C = {3'b010, w};
localparam D = {3'b100, w};
localparam E = {2'b11, w};
localparam F = {1'b1};

localparam NEXT_A = A;
localparam NEXT_B = B[0];
localparam NEXT_C = C[0];
localparam NEXT_D = D[0];
localparam NEXT_E = E[0];
localparam NEXT_F = F;

// State table
always @(*)
    case(state)
        states: z <= z_prev;
        A[1]: if(w == 1) state = NEXT_A; else state = A;
        A[0]: if(w == 1) state = NEXT_B; else state = A;
        B[0]: if(w == 1) state = C; else state = B;
        B[1]: if(w == 1) state = NEXT_C; else state = B;
    endcase

endmodule

// VERILOG-EVAL: errant inclusion of module definition
