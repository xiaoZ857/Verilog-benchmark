
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
    else if (~in && state == 2'd0) begin
        state <= 2'd0;
        output_value <= 0'b0;
    end else if ((~in || in) && state == 2'd1) begin
        state <= 2'd1;
        output_value <= 0'b0;
    end else if (state != 2'd3 && (~in || in)) begin
        state <= 2'd3;
        output_value <= 0'b1;
    end else
        output_value <= 0'b1;
end

always @(posedge in) begin
    case(state)
        2'd0 : if (in == ~in) state = 2'd1;
                else state = 2'd0;
        2'd1 : state = 2'd1;
        2'd2 : if (in == ~in || in) state = 2'd3;
                    else state = 2'd2;
        2'd3 : state = 2'd3;
    endcase
end

assign out = output_value;

endmodule
