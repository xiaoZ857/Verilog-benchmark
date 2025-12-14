
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
// Parameters and internal signals
parameter HISTORY_BITS = 7;
parameter PHT_SIZE = 128;

reg [1:0] pht[PHT_SIZE-1:0];   // Saturating counters for the PHT
reg [HISTORY_BITS-1:0] global_history; // Global branch history register

wire [6:0] pht_index;
assign pht_index = predict_pc ^ global_history; // XOR for gshare index

always @(posedge clk or posedge areset) begin
    if (areset) begin
        // Reset logic - synchronous reset assumed
        global_history <= {HISTORY_BITS{1'b0}};
        integer i;
        for (i = 0; i < PHT_SIZE; i++) begin
            pht[i] <= 2'b10; // Initialize counters to weakly taken state
        end
    end else if (train_valid) begin
        // Training logic
        if (train_mispredicted) begin
            // Recover global history to the state before mispredicted branch
            global_history <= train_history;
        end

        if (pht_index == (train_pc ^ global_history)) begin
            case (pht[pht_index])
                2'b00: pht[pht_index] <= train_taken ? 2'b01 : 2'b00; // Weakly not taken -> weakly taken / unchanged
                2'b01: pht[pht_index] <= train_taken ? 2'b11 : 2'b00; // Strongly taken -> strongly taken or weakly not taken
                2'b10: pht[pht_index] <= train_taken ? 2'b11 : 2'b01; // Weakly taken -> strongly taken / weakly not taken
                2'b11: pht[pht_index] <= train_taken ? 2'b11 : 2'b10; // Strongly taken -> unchanged / weakly taken
            endcase
        end
    end else if (predict_valid && !train_valid) begin
        // Update global history on the next clock cycle if a prediction occurred and training did not take place
        global_history <= {global_history[HISTORY_BITS-2:0], predict_taken};
    end
end

always @(*) begin
    // Default assignments to avoid latches
    predict_history = global_history;
    case (pht[pht_index])
        2'b00, 2'b01: predict_taken = 1'b0;  // Not predicted as taken
        2'b10, 2'b11: predict_taken = 1'b1;  // Predicted as taken
    endcase
end

endmodule
