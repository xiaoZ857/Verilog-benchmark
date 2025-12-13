
module TopModule (
  input clk,
  input reset,
  input x,
  output reg z
);

reg [2:0] state;
reg [2:0] next_state;

// State register
always @(posedge clk) begin
    if (reset) begin
        state <= 3'b000;
    end else begin
        state <= next_state;
    end
end

// Next state logic
always @(*) begin
    case (state)
        3'b000: begin
            if (x) next_state = 3'b001;
            else next_state = 3'b000;
        end
        3'b001: begin
            if (x) next_state = 3'b100;
            else next_state = 3'b001;
        end
        3'b010: begin
            if (x) next_state = 3'b001;
            else next_state = 3'b010;
        end
        3'b011: begin
            if (x) next_state = 3'b010;
            else next_state = 3'b001;
        end
        3'b100: begin
            if (x) next_state = 3'b100;
            else next_state = 3'b011;
        end
        default: next_state = 3'b000;
    endcase
end

// Output logic
always @(*) begin
    case (state)
        3'b011: z = 1'b1;
        3'b100: z = 1'b1;
        default: z = 1'b0;
    endcase
end

endmodule
