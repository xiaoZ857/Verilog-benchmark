
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
  input [7:0] train_pc
);

  // Parameters
  parameter HISTORY_BITS = 7;
  parameter PHT_SIZE = 128;
  parameter COUNTER_WIDTH = 2;

  // Global History Register (GHR)
  reg [HISTORY_BITS-1:0] ghr;

  // Pattern History Table (PHT) with saturating counters
  reg [COUNTER_WIDTH-1:0] pht[PHT_SIZE-1:0];

  // Internal signals
  wire [HISTORY_BITS-1:0] index;
  wire [COUNTER_WIDTH-1:0] current_counter;

  // Asynchronous reset
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      ghr <= {HISTORY_BITS{1'b0}};
      integer i;
      for (i = 0; i < PHT_SIZE; i++) begin
        pht[i] <= 2'b10; // Initialize to weakly taken state
      end
    end else begin
      if (train_valid) begin
        // Update GHR only on misprediction
        if (train_mispredicted) begin
          ghr <= train_history;
        end

        // Calculate index and update PHT
        index = predict_pc ^ ghr;
        current_counter = pht[index];

        if (train_taken) begin
          if (current_counter != 3'b11) begin
            pht[index] <= current_counter + 1;
          end
        end else begin
          if (current_counter != 2'b00) begin
            pht[index] <= current_counter - 1;
          end
        end
      end

      // Update GHR for predictions
      if (predict_valid && !train_valid) begin
        ghr <= {ghr[HISTORY_BITS-2:0], predict_taken};
      end
    end
  end

  // Prediction logic
  always @(*) begin
    if (predict_valid) begin
      index = predict_pc ^ ghr;
      current_counter = pht[index];

      // Predict taken if counter is greater than or equal to 2
      predict_taken = (current_counter >= 2'b10);
      predict_history = ghr;
    end else begin
      predict_taken = 1'b0; // Default value when not predicting
      predict_history = {HISTORY_BITS{1'b0}};
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
