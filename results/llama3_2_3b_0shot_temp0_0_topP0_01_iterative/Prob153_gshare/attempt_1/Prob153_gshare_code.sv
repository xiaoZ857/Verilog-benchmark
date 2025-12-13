
module TopModule (
  input clk,
  input areset,

  input predict_valid,
  input [6:0] predict_pc,
  output predict_taken,
  output [6:0] predict_history,

  input train_valid,
  input train_taken,
  input train_mispredicted,
  input [6:0] train_history,
  input [6:0] train_pc
);

// Global variables
reg [7:0] global_branch_history;
reg [7:0] global_history;
reg [7:0] pattern_history[127:0];
reg [7:0] history_index;

// Prediction interface
assign predict_taken = (predict_valid && global_branch_history[6] == 1'b1) ? 1'b1 : 0'b0;
assign predict_history = global_branch_history;

// Training interface
assign global_branch_history = train_valid && train_taken ? train_history : global_branch_history;
assign global_history = train_valid && train_mispredicted ? train_history : global_history;
assign history_index = train_valid && train_taken ? train_pc[6:0] : (global_history == 1'b1) ? pattern_history[train_pc[6:0]] : 127'b0;

// Update PHT at the next positive clock edge
always @(posedge clk)
if (train_valid && train_taken)
pattern_history[train_pc[6:0]] = train_history;
else if (global_branch_history == 1'b1) // Training and prediction of same PHT entry happen at the same time
pattern_history[train_pc[6:0]] = global_branch_history;

// Update branch history register for predicted branch
always @(posedge clk)
if (predict_valid && predict_taken == 0'b0)
global_branch_history = train_history;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
