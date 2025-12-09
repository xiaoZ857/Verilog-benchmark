
module TopModule (
  input clk,
  input load,
  input [9:0] data,
  output tc
);
reg [9:0] counter;
wire counter_is_zero = (counter == 10'd0);

always @(posedge clk) begin
    if (load) begin
        counter <= data;
    end else if (!counter_is_zero) begin
        counter <= counter - 10'd1;
    end
end

assign tc = counter_is_zero;

endmodule
