
module TopModule (
  input [31:0] in,
  output [31:0] out
);
always @(posedge clk) begin
    if (!reset) begin
        out <= {in[7:0], in[15:8], in[23:16], in[31:24]}; // Reversed byte order
    end else begin
        out <= in; // Reset the output to input when reset is asserted
    end
end

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
    if (n_rst) begin
        temp <= 32'b0;
    end else begin
        temp <= out;
    end
end

// Assign the reversed byte order to the temporary register when synchronous reset is deasserted and asynchronous reset is not asserted.
always @(posedge clk or negedge rst or posedge n_rst) begin
    if (!reset && !n_rst) begin
        temp <= {in[7:0], in[15:8], in[23:16], in[31:24]};
    end
end

// Finally, assign the temporary register to the output when both synchronous and asynchronous resets are deasserted.
always @(posedge clk or negedge rst or posedge n_rst) begin
    if (!reset && !n_rst) begin
        out <= temp;
    end
end

endmodule
