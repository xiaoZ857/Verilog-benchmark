
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
module gshare_branch_predictor(
    // Clock and reset signals
    input clk,
    input areset,

    // Prediction interface
    input predict_valid, // Request for branch prediction
    input [6:0] predict_pc,  // Predicted PC address
    output reg [6:0] predict_taken, // Predicted branch direction
    output reg [6:0] predict_history // Updated branch history register

    // Training interface
    input train_valid, // Request for training
    input train_taken, // Actual taken branch flag
    input train_mispredicted, // Actual branch misprediction flag
    input [6:0] train_history, // Branch history register value before training
    input [6:0] train_pc // PC address being trained

);

// Global branch history register and table of counters for predicted branches
reg [7:0] global_branch_history;
reg [8:0][7:0] pattern_history_table;

// Current instruction's branch prediction and history
reg [7:0] current_instruction_prediction;
reg [7:0] current_instruction_history;

// Initialize the branch history register and table of counters
always @(posedge clk or negedge areset)
begin
    if (!areset) begin
        global_branch_history <= 0;
        pattern_history_table <= 128'b0;
        current_instruction_prediction <= 0;
        current_instruction_history <= 0;
    end else begin
        // Initialize branch history table with all entries to saturating zeros (00)
        for(int i = 0; i < 128; i++) begin
            pattern_history_table[i][7:0] <= 8'b0;
        end
    end
end

// Branch prediction logic
always @(posedge clk or negedge predict_valid)
begin
    if (predict_valid) begin
        // Calculate the index for accessing the branch history table
        reg [3:0] xor_index = predict_pc ^ global_branch_history;

        // Get the saturation counter for this predicted branch location
        pattern_history_table[xor_index][7:0] <= 8'b1;

        // Update the branch history register with this prediction result
        if (!train_valid) begin
            global_branch_history <= xor_index;
        end

        // Predicted branch direction (taken or not)
        predict_taken <= 8'b1; // 8'b111, indicating taken branch
        predict_history <= global_branch_history;

        // Store current instruction prediction for future training
        if (!train_valid) begin
            current_instruction_prediction <= xor_index;
            current_instruction_history <= global_branch_history;
        end
    end else begin
        predict_taken <= 1'b0; // Default to not taken branch
        predict_history <= 7'b0;
        current_instruction_prediction <= 1'b0;
        current_instruction_history <= 1'b0;
    end
end

// Training logic
always @(posedge clk or negedge train_valid)
begin
    if (train_valid) begin
        // Update the saturation counter for this training case
        if (current_instruction_pc == train_pc && train_taken) begin
            pattern_history_table[current_instruction_prediction][7:0] <= 8'b1;
        end else if (current_instruction_pc == train_pc && train_taken && train_mispredicted) begin
            // Recover branch history register to state immediately after mispredicting branch completes execution
            current_instruction_history <= global_branch_history;
            pattern_history_table[current_instruction_prediction][6:0] <= 8'b1; // Update saturating counter based on misprediction
        end else if (current_instruction_pc == train_pc && !train_taken) begin
            pattern_history_table[current_instruction_prediction][7:0] <= 8'b0;
        end

        // Update branch history register with this training result
        global_branch_history <= current_instruction_history;

        // Train the branch predictor at the next positive clock edge
        if (!predict_valid && !train_mispredicted) begin
            pattern_history_table[xor_index][6:0] <= 8'b1; // Update saturating counter based on correct prediction
        end
    end else begin
        current_instruction_prediction <= 1'b0;
        current_instruction_history <= 1'b0;
    end
end

endmodule
