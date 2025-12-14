
module TopModule (
  input clk,
  input in,
  input reset,
  output out
);

reg [1:0] state;
reg [1:0] output_value;

always @(posedge clk) begin
    if (reset)
        state <= 2'a; // A
    else
        case(state)
            2'd0 : state = 2'd0, output_value <= 0'b0;
            2'd1 : state = 2'd1, output_value <= 0'b0;
            2'd2 : state = 2'd2, output_value <= 0'b1;
            2'd3 : state = 2'd3, output_value <= 0'b1;
        endcase
end

always @(posedge in) begin
    case(state)
        2'd0 : state = 2'd0; // A
        2'd1 : state = 2'd1; // B
        2'd2 : state = 2'd3; // C -> D
        2'd3 : state = 2'd3; // D
    endcase
end

assign out = output_value;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
