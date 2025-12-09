

module TopModule (
  input clk,
  input areset,
  input x,
  output z
);

always @(posedge clk or negedge areset)
begin
    if (!areset) 
        state <= A;
    else
        case (state)
            A: 
                if (x == 0) 
                    state <= A;
                else if (x == 1) 
                    state <= B;
            B:
                if (x == 0) 
                    state <= B;
                else if (x == 1) 
                    state <= B;
        endcase
    case (state)
        A: z <= ~x;
        B: z <= x;
    endcase
end

reg [1:0] state = A;

assign z = {z, ~z};

// VERILOG-EVAL: endmodule not found
