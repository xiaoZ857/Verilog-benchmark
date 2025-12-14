
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

// Global branch history register
reg [6:0] global_history;
wire [7:0] index;

// Pattern History Table (128 entries, 2-bit counters)
reg [1:0] pht[0:127];

always_ff @(posedge clk) begin
    if (areset) begin
        global_history <= 0;
        pht <= '{default: 0}; // Initialize all PHT entries to 0
    end else begin
        // Update global history based on prediction and training
        if (predict_valid && !train_valid) begin
            index = predict_pc ^ global_history;
            unique case (index)
                default: 
                    global_history <= predict_taken ? global_history + 1 : global_history - 1;
            endcase
        end else if (train_valid) begin
            // Training has precedence over prediction
            index = train_pc ^ train_history;
            if (train_mispredicted) begin
                // Rollback the branch history
                global_history <= train_history; // Restore to state before mispredicted branch
            end
        end
    end
end

always_latch begin
    if (predict_valid) begin
        index = predict_pc ^ global_history;
        // Determine predicted taken and next history state
        case (pht[index])
            0: 
                predict_taken = 0;
                unique case ({global_history, predict_pc})
                    default: global_history_next = global_history; // No change for non-taken branches
                endcase;
            1: 
                predict_taken = 1;
                unique case ({global_history, predict_pc}) 
                    default: global_history_next = global_history + 1; // Increment on taken branch prediction
                endcase;
            2: 
                predict_taken = 1;
                unique case ({global_history, predict_pc})
                    default: global_history_next = $signed(global_history) - 1; // Decrement on overflow
                endcase;
        endcase;
    end
end

always_ff @(posedge clk) begin
    if (train_valid) begin
        index = train_pc ^ train_history;
        if (train_taken) begin
            pht[index] <= $signed(pht[index]) + 1; // Increment counter for taken branch
        else begin
            pht[index] <= $signed(pht[index]) - 1; // Decrement counter for not-taken branch
        end
    end
end

end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
