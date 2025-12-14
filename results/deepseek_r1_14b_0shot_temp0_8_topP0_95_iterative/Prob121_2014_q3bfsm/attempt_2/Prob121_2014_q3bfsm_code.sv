
module TopModule (
  input clk,
  input reset,
  input x,
  output reg z
);

  // State declaration
  reg [2:0] y;
  
  // Next state and output calculation
  always @(*) begin
    case (y)
      000:
        if (x == 0) 
          {z, next_y} = 0, 000;
        else
          {z, next_y} = 0, 001;
      001:
        if (x == 0) 
          {z, next_y} = 0, 001;
        else
          {z, next_y} = 0, 100;
      010:
        if (x == 0) 
          {z, next_y} = 0, 010;
        else
          {z, next_y} = 0, 001;
      011:
        if (x == 0) 
          {z, next_y} = 1, 001;
        else
          {z, next_y} = 1, 010;
      default:
        {z, next_y} = 1, 100;  // Default case for invalid states
    endcase
  end

  // State update on clock edge with reset
  always @(posedge clk or posedge reset) begin
    if (reset)
      y <= 000;
    else 
      y <= next_y;
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
