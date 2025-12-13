
module TopModule (
  input clk,
  input enable,
  input S,
  input A,
  input B,
  input C,
  output reg Z
);
// Define the 8-bit shift register with D-type flip-flops
module ShiftRegister(
    input clk, // Positive clock/clk triggered
    input enable, // Synchronous active high
    input [7:0] S, // Shift-in bits
    output reg [7:0] Q // Flip-flop outputs (Q[0] to Q[7])
);

    // Initialize the flip-flops with all zeros
    reg [7:0] q[8:0];

    always @(posedge clk) begin
        if (enable) begin
            // Shift in new bits and update the flip-flops
            for (int i = 7; i >= 0; i--) begin
                q[i + 1] <= q[i];
            end
            q[0] <= S;
        end else begin
            // Hold the current state when enable is low
            for (int i = 8; i > 0; i--) begin
                q[i - 1] <= q[i];
            end
        end
    end

endmodule

// Define the multiplexer with 3 inputs and 8-bit output
module Multiplexer(
    input clk, // Positive clock/clk triggered
    input enable, // Synchronous active high
    input [2:0] ABC, // 3-input logic function
    input [7:0] Q, // Input to the multiplexer
    output reg Z // Output of the multiplexer
);

    // Define the 8-bit output of the multiplexer
    reg [7:0] z;

    always @(posedge clk) begin
        if (enable) begin
            // Select the correct bit based on the ABC input
            case (ABC)
                000: z = Q[0];
                001: z = Q[1];
                010: z = Q[2];
                011: z = Q[3];
                100: z = Q[4];
                101: z = Q[5];
                110: z = Q[6];
                111: z = Q[7];
                default: z = 0;
            endcase
        end else begin
            // Hold the current state when enable is low
            z <= Q;
        end
    end

endmodule

// Define the TopModule with the shift register and multiplexer
module TopModule(
    input clk, // Positive clock/clk triggered
    input enable, // Synchronous active high
    input [7:0] S, // Shift-in bits
    input [2:0] ABC, // 3-input logic function
    output reg Z // Output of the multiplexer
);

    ShiftRegister shiftReg(
        .clk(clk),
        .enable(enable),
        .S(S),
        .Q(Q)
    );

    Multiplexer multiplexer(
        .clk(clk),
        .enable(enable),
        .ABC(ABC),
        .Q(Q[7:0]),
        .Z(Z)
    );

endmodule

// VERILOG-EVAL: errant inclusion of module definition
