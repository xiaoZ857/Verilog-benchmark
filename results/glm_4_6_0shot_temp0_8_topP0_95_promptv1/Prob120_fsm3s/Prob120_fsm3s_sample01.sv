
module TopModule (
  input clk,
  input in,
  input reset,
  output out
);

parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

reg [1:0] current_state, next_state;
reg out_reg;

always @(posedge clk) begin
    if (reset) begin
        current_state <= A;
    end else begin
        current_state <= next_state;
    end
end

always @(*) begin
    next_state = current_state;
    out_reg = 1'b0;
    
    case (current_state)
        A: begin
            out_reg = 1'b0;
            next_state = in ? B : A;
        end
        B: begin
            out_reg = 1'b0;
            next_state = in ? B : C;
        end
        C: begin
            out_reg = 1'b0;
            next_state = in ? D : A;
        end
        D: begin
            out_reg = 1'b1;
            next_state = in ? B : C;
        end
    endcase
end

assign out = out_reg;

endmodule
