
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
  reg [HISTORY_SIZE-1:0] predict_history_reg; // To output the history used for prediction

  // Hash function
  function automatic integer hash_function (input [6:0] pc, input [6:0] history);
    return (pc ^ history) & (PHT_SIZE - 1);
  endfunction

  // Prediction Logic
  always_comb begin
    // Default values
    predict_taken = 1'b0;
    predict_history = global_history;

    // Calculate index
    integer index = hash_function(predict_pc, global_history);

    // Predict based on PHT
    case (pht[index][1])
      2'b00: predict_taken = 1'b0;
      2'b01: predict_taken = 1'b0;
      2'b10: predict_taken = 1'b1;
      2'b11: predict_taken = 1'b1;
    endcase
  end

  // Training Logic
  always @(posedge clk) begin
    if (areset) begin
      global_history <= 0;
      for (integer i = 0; i < PHT_SIZE; i = i + 1) begin
        pht[i] <= 2'b00;
      end
    end else begin
      if (train_valid) begin
        integer index = hash_function(train_pc, train_history);
        case (train_taken)
          1'b0: pht[index] <= (train_mispredicted) ? 2'b00 : 2'b01;
          1'b1: pht[index] <= (train_mispredicted) ? 2'b10 : 2'b11;
        endcase

        // Update global history
        if (train_taken) begin
          global_history <= {global_history[HISTORY_SIZE-2:0], train_taken};
        end
      end
    end
  end

  // Store history for prediction
  always @(posedge clk) begin
    if (predict_valid) begin
        predict_history_reg <= global_history;
    end
  end

  // Output
  assign predict_history = predict_history_reg;
endmodule

// VERILOG-EVAL: errant inclusion of module definition
