
module TopModule (
  input clk,
  input load,
  input [9:0] data,
  output tc
);

  reg [9:0] counter;
  
  always @* begin
    if (load) begin
      counter <= data;
      tc <= 0;
    end else begin
      if (counter != 0) begin
        counter <= counter - 1;
      end
      tc <= (counter == 0);
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
