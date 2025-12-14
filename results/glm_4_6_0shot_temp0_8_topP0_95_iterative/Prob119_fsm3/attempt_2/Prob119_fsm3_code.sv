
module TopModule (
  input clk,
  input in,
  input areset,
  output out
);
  // State encoding
  localparam A = 2'b00;
  localparam B = 2'b01;
  localparam C = 2'b10;
  localparam D = 2'b11;
  
  // State register
  reg [1:0] state;
  
  // Next state logic
  reg [1:0] next_state;
  
  always @(*) begin
    case (state)
      A: begin
        if (in) next_state = B;
        else next_state = A;
      end
      B: begin
        if (in) next_state = B;
        else next_state = C;
      end
      C: begin
        if (in) next_state = D;
        else next_state = A;
      end
      D: begin
        if (in) next_state = B;
        else next_state = C;
      end
      default: next_state = A;
    endcase
  end
  
  // State update with async reset
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= A;
    end else begin
      state <= next_state;
    end
  end
  
  // Output logic (Moore machine - output depends only on current state)
  assign out = (state == D);

endmodule
