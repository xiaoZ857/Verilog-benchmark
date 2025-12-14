
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

reg [6:0] ghr; // Global History Register
reg [1:0] pht [0:127]; // Pattern History Table with 128 2-bit entries

wire [6:0] predict_index = predict_pc ^ ghr;
wire [6:0] train_index = train_pc ^ train_history;

reg predict_taken_reg;
reg [6:0] predict_history_reg;

// Prediction logic
always @(*) begin
  predict_taken_reg = 1'b0;
  predict_history_reg = 7'b0;
  if (predict_valid) begin
    predict_taken_reg = pht[predict_index][1]; // MSB determines prediction
    predict_history_reg = ghr;
  end
end

// Assign outputs
assign predict_taken = predict_taken_reg;
assign predict_history = predict_history_reg;

// Sequential logic for updates
always @(posedge clk or posedge areset) begin
  if (areset) begin
    ghr <= 7'b0;
    // Initialize PHT to weakly not taken (01)
    integer i;
    for (i = 0; i < 128; i = i + 1) begin
      pht[i] <= 2'b01;
    end
  end else begin
    // Update PHT based on training
    if (train_valid) begin
      case (pht[train_index])
        2'b00: begin // Strong not taken
          if (train_taken) pht[train_index] <= 2'b01;
          else pht[train_index] <= 2'b00;
        end
        2'b01: begin // Weak not taken
          if (train_taken) pht[train_index] <= 2'b10;
          else pht[train_index] <= 2'b00;
        end
        2'b10: begin // Weak taken
          if (train_taken) pht[train_index] <= 2'b11;
          else pht[train_index] <= 2'b01;
        end
        2'b11: begin // Strong taken
          if (train_taken) pht[train_index] <= 2'b11;
          else pht[train_index] <= 2'b10;
        end
      endcase
      
      // Update global history register - training takes precedence
      if (train_mispredicted) begin
        // Recover to state after mispredicting branch
        ghr <= {train_history[5:0], train_taken};
      end else begin
        // Update with actual outcome
        ghr <= {ghr[5:0], train_taken};
      end
    end else if (predict_valid) begin
      // Update global history register with prediction
      ghr <= {ghr[5:0], predict_taken_reg};
    end
  end
end

endmodule
