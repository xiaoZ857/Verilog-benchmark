
module TopModule (
  input clk,
  input aresetn,
  input x,
  output reg z
);
 ```verilog
reg [1:0] state; // State variables
always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= 2'b00; // Reset to initial state
    end else begin
        case (state)
            2'b00: begin
                if (x)
                    state <= 2'b01;
            end,
            2'b01: begin
                if (!x)
                    state <= 2'b10;
            end,
            2'b10: begin
                if (x)
                    state <= 2'b00; // Reset back to initial state
                else if ((state == 2'b10) && (x[1:0] == 3'b011))
                    z <= 1'b1; // Output asserted on "101" sequence detection
            end
        endcase
    end
end
assign z_out = z; // Wire output for z
endmodule

// VERILOG-EVAL: abnormal backticks count
