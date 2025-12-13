
module TopModule (
  input [31:0] in,
  output [31:0] out
);
reg [31:0] temp;
assign reset = ~rst; // Assuming rst is the reset input

// Synchronous reset
reg rst;
assign clk_r = ~clk; // Assuming clk is the clock input
always @(posedge clk_r) begin
    if (reset == 1'b0) begin
        rst <= 1'b1;
    end else begin
        rst <= 1'b0;
    end
end

// Asynchronous reset
assign n_rst = ~rst; // Assuming n_rst is the active-low asynchronous reset input
always @(posedge clk or negedge n_rst) begin
    if (n_rst == 1'b0) begin
        temp <= 32'b0;
    end else if (reset == 1'b1 && n_rst == 1'b1) begin
        temp <= out; // Reset the output to input when both synchronous and asynchronous resets are asserted
    end
end

always @(posedge clk) begin
    if (!reset && !n_rst) begin
        temp <= {in[7:0], in[15:8], in[23:16], in[31:24]}; // Reversed byte order
    end else if (reset == 1'b1 || n_rst == 1'b1) begin
        temp <= out; // Reset the output to input when either synchronous or asynchronous reset is asserted
    end
end

// Finally, assign the temporary register to the output when both synchronous and asynchronous resets are deasserted.
always @(posedge clk or negedge rst or posedge n_rst) begin
    if (!reset && !n_rst) begin
        out <= temp;
    end
end

endmodule
