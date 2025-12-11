
module TopModule (
  input clk,
  input load,
  input [9:0] data,
  output tc
);
reg [9:0] counter;
reg tc_reg;

always @(posedge clk) begin
    if (load) begin
        counter <= data;
        tc_reg <= (data == 10'd0) ? 1'b1 : 1'b0;
    end else begin
        if (counter != 10'd0) begin
            counter <= counter - 1;
            if (counter - 1 == 10'd0)
                tc_reg <= 1'b1;
            else
                tc_reg <= tc_reg;
        end else begin
            counter <= counter;
            tc_reg <= tc_reg;
        end
   

// VERILOG-EVAL: endmodule not found
