
module TopModule (
  input clk,
  input areset,
  input train_valid,
  input train_taken,
  output logic [1:0] state
);
// Internal signals
logic [2:0] count;
logic reg_en;

module Adder3bit (
  input logic [1:0] A,
  input logic B,
  output logic [2:0] C
);

assign C[2] = A;
assign C[1] = B;
assign C[0] = 1'b0;

endmodule

module Subtractor3bit (
  input logic [1:0] A,
  input logic B,
  output logic [2:0] C
);

assign C[2] = ~A;
assign C[1] = B;
assign C[0] = 1'b0;

endmodule

module TopModule (
  input clk,
  input areset,
  input train_valid,
  input train_taken,
  output logic [1:0] state
);

// Initialize count to weakly not-taken (2'b01)
logic reg_en;
assign areset = reg_en;
reg_en <= 0;

Adder3bit add (
  .A(train_valid),
  .B(train_taken),
  .C(count[2:])
);

Subtractor3bit sub (
  .A(!train_valid),
  .B(train_taken),
  .C(count)
);

// Increment operation
always @(posedge clk) begin
    reg_en <= train_valid && train_taken;
end

// Decrement operation
assign state = count;

// Change the value of count based on feedback from Adder3bit and Subtractor3bit
always @(posedge clk) begin
    if (reg_en)
        count[2] <= add.C[0];
    else if (!reg_en && train_taken)
        count[0] <= sub.C[1];
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
