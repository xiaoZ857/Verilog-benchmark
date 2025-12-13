
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
  // Parameters
  parameter PHT_SIZE = 128;
  parameter HISTORY_SIZE = 7;

  // Internal Signals
  reg [HISTORY_SIZE-1:0] global_history;
  reg [PHT_SIZE-1:0] pht [0:PHT_SIZE-1];
  reg [HISTORY_SIZE-1:0] predict_history_out;

  // Helper function to calculate index
  function integer calculate_index;
    input [HISTORY_SIZE-1:0] history;
    input [6:0] pc;
    return (pc ^ history) & (PHT_SIZE - 1);
  endfunction

  // Prediction Interface
  always @(posedge clk) begin
    if (predict_valid) begin
      integer index = calculate_index(global_history, predict_pc);
      predict_taken = pht[index][1]; // Two-bit counter, MSB is taken
      predict_history = global_history;
    end
  end

  // Training Interface
  always @(posedge clk) begin
    if (train_valid) begin
      integer index = calculate_index(global_history, train_pc);

      // Update PHT based on training outcome
      if (train_taken) begin
        if (pht[index][0] < 1) pht[index][0] <= 1;
        else pht[index][0] <= 2;
        if (pht[index][1] < 1) pht[index][1] <= 1;
        else pht[index][1] <= 2;
      end else begin
        if (pht[index][0] > 0) pht[index][0] <= 0;
        else pht[index][0] <= 0;
        if (pht[index][1] > 0) pht[index][1] <= 0;
        else pht[index][1] <= 0;
      end

      // Update global history if mispredicted
      if (train_mispredicted) begin
        // Recover global history to the state immediately after the mispredicting branch completes execution.
        // This is a placeholder.  In a real implementation, you's need to store the history
        // and restore it here.  For this example, we just clear it.
        global_history <= 0;
      end
    end
  end

  // Global History Update
  always @(posedge clk) begin
    if (train_valid) begin
      if (train_taken) begin
        global_history <= global_history | 1;
      end else begin
        global_history <= global_history & ~1;
      end
    end
  end

  // Asynchronous Reset
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      global_history <= 0;
      pht <= 0;
      predict_history_out <= 0;
    end
  end

endmodule
