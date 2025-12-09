
module TopModule (
  input clk,
  input reset,
  input w,
  output reg [1:0] z
);

always @(*) begin
  // State table
  case(z)
    2'd0: z = 2'd0; // A
    2'd1: z = 2'd1; // B
    2'd2: z = 2'd2; // C
    2'd3: z = 2'd3; // D
    2'd4: z = 2'd4; // E
    2'd5: z = 2'd5; // F
    default: z = 2'd0;
  endcase
end

always @(posedge clk) begin
  if(reset) begin
    z <= 2'd0;
  end else begin
    // State flip-flops
    case(z)
      2'd0: z <= 2'd1; // A -> B
      2'd1: z <= 2'd0; // B -> A
      2'd2: z <= 2'd3; // C -> D
      2'd3: z <= 2'd4; // D -> E
      2'd4: z <= 2'd5; // E -> F
      2'd5: z <= 2'd0; // F -> A
    endcase
  end
end

always @(posedge w) begin
  if(z == 2'd1) begin
    z <= 2'd4;
  end else if (z == 2'd3) begin
    z <= 2'd5;
  end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
