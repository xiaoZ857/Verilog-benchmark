
`timescale 1ns / 1ps

module TopModule (
  input clk,
  input areset,
  input predict_valid,
  input predict_taken,
  output logic [31:0] predict_history,

  input train_mispredicted,
  input train_taken,
  input [31:0] train_history
);

  // Internal signals
  logic shift_in;
  logic [32:0] new_history;  // Using 33 bits to avoid overflow during concatenation

  // Mux to select between shifting and loading new history
  always_comb begin
    if (train_mispredicted) begin
      new_history = {train_history, train_taken};
      predict_history = new_history[31:0];  // Assign only the lower 32 bits
    end else begin
      shift_in = predict_taken & predict_valid;
      predict_history = (predict_history << 1) | shift_in;
    end
  end

  // Asynchronous reset
  always_ff @(posedge areset) begin
    predict_history <= 0;
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
