
module TopModule (
  input clk,
  input a,
  output reg [2:0] q
);
always @(posedge clk) begin
    if (a == 1'b1) begin
        // Maintain q when 'a' is high
        q <= q;
    end else begin
        // Increment q when 'a' is low, except for reset condition
        if (q == 3'b110) begin
            q <= 3'b000; // Reset to zero when q reaches 6
        end else begin
            q <= q + 1;
        end
    end
end

// Initialize q at the start
initial begin
    q = 3'b000;
end

endmodule
