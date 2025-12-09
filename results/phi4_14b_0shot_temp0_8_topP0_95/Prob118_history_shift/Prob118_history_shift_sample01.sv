
module TopModule (
    input logic clk,
    input logic areset,
    input logic predict_valid,
    input logic predict_taken,
    
    output logic [31:0] predict_history,

    input logic train_mispredicted,
    input logic train_taken,
    input logic [31:0] train_history
);

    // Register to hold the current branch history
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            // Asynchronous reset sets the history register to zero
            predict_history <= 32'b0;
        end else begin
            if (train_mispredicted) begin
                // On misprediction, load the corrected branch history
                predict_history <= {train_history[30:0], train_taken};
            end else if (predict_valid) begin
                // Shift in predict_taken to update history for prediction
                predict_history <= {predict_history[30:0], predict_taken};
            end
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
