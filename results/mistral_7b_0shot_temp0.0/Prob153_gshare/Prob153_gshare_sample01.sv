
module TopModule (
  input clk,
  input areset,

  input predict_valid,
  input [6:0] predict_pc,
  output reg predict_taken,
  output reg [6:0] predict_history,

  input train_valid,
  input train_taken,
  input train_mispredicted,
  input [6:0] train_history,
  input [6:0] train_pc
);

reg [127:0] PHT; // Pattern History Table (128-entry two-bit saturating counters)
reg [6:0] global_branch_history; // Global branch history register

always @(posedge clk or negedge areset) begin
  if (!areset) begin
    PHT <= 7'b0; // Reset PHT to zero
    global_branch_history <= 7'b0; // Reset global_branch_history to zero
  end
end

always @(posedge clk) begin
  if (train_valid && !global_branch_history[6]) begin // Train when the branch history register is empty
    case (PHT[(train_pc ^ global_branch_history)[7:0])] // Access PHT using XOR hashing
      2'b00 : PHT[(train_pc ^ global_branch_history)[7:0]] <= train_taken ? 2'b11 : 2'b01; // Update PHT based on the actual branch outcome
      default : PHT[(train_pc ^ global_branch_history)[7:0]] <= 2'b00; // If misprediction, recover the branch history register
    endcase

    if (train_mispredicted) begin // Recover the branch history register for a misprediction
      case (global_branch_history[6:1])
        7'b0000000 : global_branch_history <= train_history; // If empty, update with the new history
        default : global_branch_history <= {global_branch_history[5:0], train_history}; // Otherwise, shift and append the new history
      endcase
    end
  end
end

always @(posedge clk) begin
  if (predict_valid) begin // Predict when the branch history register is not empty
    case (PHT[(predict_pc ^ global_branch_history)[7:0]]) // Access PHT using XOR hashing
      2'b11 : predict_taken <= 1'b1; // If counter value is max, predict taken
      2'b01 : predict_taken <= 1'b0; // If counter value is min, predict not taken
      default : predict_taken <= global_branch_history[6]; // Otherwise, use the most recent history bit as prediction
    endcase

    global_branch_history <= {global_branch_history[6:1], predict_taken}; // Update the branch history register with the prediction
  end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
