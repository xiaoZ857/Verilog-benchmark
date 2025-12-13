
module TopModule (
  input clk,
  input areset,
  input train_valid,
  input train_taken,
  output logic [1:0] state
);
// Internal signals for the counter
logic [2:0] count; // 3-bit counter

// Initialize the counter to weakly not-taken (2'b01) on reset
always @(posedge areset or posedge clk) begin
    if (areset) begin
        count <= 2'd1;
    end else begin
        count <= count;
    end
end

// Increment the counter when train_valid = 1 and train_taken = 1
always @(posedge clk) begin
    if (train_valid && train_taken) begin
        if (count == 3'd3) begin // Maximum value reached, wrap around to 0
            count <= 2'd0;
        end else begin // Increment the counter
            count <= count + 1;
        end
    end
end

// Decrement the counter when train_valid = 1 and train_taken = 0
always @(posedge clk) begin
    if (train_valid && !train_taken) begin
        if (count == 2'd0) begin // Minimum value reached, wrap around to 3
            count <= 2'd3;
        end else begin // Decrement the counter
            count <= count - 1;
        end
    end
end

// Output the two-bit counter value
assign state = {count[1], count[0]};

endmodule
