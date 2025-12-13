
module TopModule (
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q
);
always @(posedge clk) begin
    if (load) begin
        // Load new data into q when load is high
        q <= data;
    end else begin
        // Compute the next state for each cell
        for (int i = 0; i < 512; i++) begin
            // Determine the indices of the neighbors, considering wrap-around
            int left = (i + 1) % 512;
            int right = (i - 1 + 512) % 512;

            // Apply Rule 110 based on the current state and its neighbors
            case ({q[left], q[i], q[right]})
                3'b111: next_q[i] = 0;
                3'b110: next_q[i] = 1;
                3'b101: next_q[i] = 1;
                3'b100: next_q[i] = 0;
                3'b011: next_q[i] = 1;
                3'b010: next_q[i] = 1;
                3'b001: next_q[i] = 1;
                3'b000: next_q[i] = 0;
            endcase
        end

        // Update the current state with the computed next state
        q <= next_q;
    end
endmodule
