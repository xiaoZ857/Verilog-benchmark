
module TopModule (
  input clk,
  input reset,
  input w,
  output z
);
assign z = reg[z];
initial z = 1'b0;

always @(*) begin
    case(z)
        3'b000: z = 3'b001;
        3'b001: z = 3'b010;
        3'b010: z = 3'b100;
        3'b100: z = 3'b011;
        default: z = 3'b000;
    endcase
end

always @(posedge clk) begin
    if (reset)
        q <= 2'b00;
    else
        switch(q)
            case(2'b00): q <= 1'b10;
            case(2'b01): q <= 1'b11;
            case(2'b10): q <= 2'b00;
            default: q <= 2'b11;
        endcase
end

always @(*) begin
    case(q)
        2'b00: z = 3'b000;
        2'b01: z = 3'b001;
        2'b10: z = 3'b010;
        2'b11: z = 3'b011;
        default: z = 3'b100;
    endcase
end

// VERILOG-EVAL: endmodule not found
