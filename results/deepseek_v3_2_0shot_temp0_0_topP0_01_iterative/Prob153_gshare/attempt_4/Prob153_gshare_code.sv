
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
reg [6:0] ghr;
reg [1:0] pht [0:127];

wire [6:0] predict_index = predict_pc ^ ghr;
wire [6:0] train_index = train_pc ^ train_history;

// Prediction output - uses current GHR and PHT state
assign predict_taken = pht[predict_index][1];
assign predict_history = ghr;

// PHT update logic
integer i;
always @(posedge clk or posedge areset) begin
    if (areset) begin
        ghr <= 7'b0;
        for (i = 0; i < 128; i = i + 1) begin
            pht[i] <= 2'b01; // weakly not-taken
        end
    end else begin
        // Training logic - always has priority for GHR updates
        if (train_valid) begin
            // Update PHT for training index
            if (train_taken) begin
                case (pht[train_index])
                    2'b00: pht[train_index] <= 2'b01;
                    2'b01: pht[train_index] <= 2'b10;
                    2'b10: pht[train_index] <= 2'b11;
                    2'b11: pht[train_index] <= 2'b11;
                endcase
            end else begin
                case (pht[train_index])
                    2'b00: pht[train_index] <= 2'b00;
                    2'b01: pht[train_index] <= 2'b00;
                    2'b10: pht[train_index] <= 2'b01;
                    2'b11: pht[train_index] <= 2'b10;
                endcase
            end

            // Update GHR based on training
            if (train_mispredicted) begin
                // Recover to state after mispredicted branch
                ghr <= {train_history[5:0], train_taken};
            end else begin
                // Normal training update with actual outcome
                ghr <= {ghr[5:0], train_taken};
            end
        end else if (predict_valid) begin
            // Only update ghr with prediction if no training in this cycle
            ghr <= {ghr[5:0], predict_taken};
        end
        // If neither predict_valid nor train_valid, ghr remains unchanged
    end
end
endmodule
