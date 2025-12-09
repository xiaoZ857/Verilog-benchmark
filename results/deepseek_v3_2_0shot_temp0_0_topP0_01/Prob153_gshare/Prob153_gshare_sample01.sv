
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
    // 2-bit saturating counter states
    localparam STRONG_NOT_TAKEN = 2'b00;
    localparam WEAK_NOT_TAKEN   = 2'b01;
    localparam WEAK_TAKEN       = 2'b10;
    localparam STRONG_TAKEN     = 2'b11;

    // Internal registers
    reg [6:0] ghr;
    reg [1:0] pht [0:127];

    // Index calculation (7-bit XOR of PC and GHR)
    wire [6:0] predict_index;
    wire [6:0] train_index;

    assign predict_index = predict_pc ^ ghr;
    assign train_index = train_pc ^ train_history;

    // Prediction logic (combinational)
    reg predict_taken_reg;
    reg [6:0] predict_history_reg;

    always @(*) begin
        if (predict_valid) begin
            predict_taken_reg = pht[predict_index][1]; // MSB determines direction
            predict_history_reg = ghr;
        end else begin
            predict_taken_reg = 1'b0;
            predict_history_reg = 7'b0;
        end
    end

    assign predict_taken = predict_taken_reg;
    assign predict_history = predict_history_reg;

    // Sequential updates
    integer i;
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset GHR and all PHT entries
            ghr <= 7'b0;
            for (i = 0; i < 128; i = i + 1) begin
                pht[i] <= WEAK_TAKEN; // Initialized to weakly taken
            end
        end else begin
            // Training has priority over prediction updates
            if (train_valid) begin
                // Update PHT based on actual outcome
                case (pht[train_index])
                    STRONG_NOT_TAKEN: pht[train_index] <= train_taken ? WEAK_NOT_TAKEN : STRONG_NOT_TAKEN;
                    WEAK_NOT_TAKEN:   pht[train_index] <= train_taken ? WEAK_TAKEN : STRONG_NOT_TAKEN;
                    WEAK_TAKEN:       pht[train_index] <= train_taken ? STRONG_TAKEN : WEAK_NOT_TAKEN;
                    STRONG_TAKEN:     pht[train_index] <= train_taken ? STRONG_TAKEN : WEAK_TAKEN;
                endcase

                // Update GHR: shift in actual outcome, but restore if mispredicted
                if (train_mispredicted) begin
                    // Restore to train_history then shift in actual outcome
                    ghr <= {train_history[5:0], train_taken};
                end else begin
                    // Normal update: shift in actual outcome
                    ghr <= {ghr[5:0], train_taken};
                end
            end else if (predict_valid) begin
                // Only update GHR with prediction if no training
                ghr <= {ghr[5:0], predict_taken_reg};
            end
        end
    end
endmodule
