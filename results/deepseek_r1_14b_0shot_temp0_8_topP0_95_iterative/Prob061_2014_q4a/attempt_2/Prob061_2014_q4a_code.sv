
module TopModule (
  input clk,
  input w,
  input R,
  input E,
  input L,
  output reg Q
);
module top_module (
  input clk,
  input w,
  input R,
  input E,
  input L,
  output reg Q
);

  // Internal wires
  wire load_enable;
  
  // Flip-flop
  reg q;
  
  // Mux for next state
  always @* begin
    case ({E, L})
      2'b00: 
        if (!q) 
          q <= R;
      2'b10:
        q <= w;
      default:
        if (L)
          q <= R;
        else 
          q <= E ? w : q;
    endcase
  end
  
  // Assign output Q
  assign Q = q;

endmodule
