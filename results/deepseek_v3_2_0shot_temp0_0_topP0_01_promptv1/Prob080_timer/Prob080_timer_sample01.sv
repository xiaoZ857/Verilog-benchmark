
module TopModule (
  input clk,
  input load,
  input [9:0] data,
  output tc
);
always @(posedge clk) begin
    if (load) begin
        tc <= (data == 10'b0);
    end else if (!tc) begin
        tc <= (data == 10'b1);
    end
end

reg [9:0] counter;

always @(posedge clk) begin
    if (load) begin
        counter <= data;
    end else if (counter != 10'b0) begin
        counter <= counter - 10'b1;
    end
end

assign tc = (counter == 10'b0);
endmodule
