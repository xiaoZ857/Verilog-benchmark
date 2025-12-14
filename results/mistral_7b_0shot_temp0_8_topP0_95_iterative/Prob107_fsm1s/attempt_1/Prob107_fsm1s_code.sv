
module TopModule (
  input wire clk,
  input wire in,
  input wire reset,
  output reg out
);

reg currState; // Current state of the state machine
param B = 0;
param A = 1;

always @(posedge clk) begin
    if (reset) begin
        currState <= B;
    end else begin
        case (currState)
            B: begin
                if (in == 0) begin
                    currState <= A;
                    out <= 1;
                end else if (in == 1) begin
                    currState <= B;
                    out <= 1;
                end
            end
            A: begin
                if (in == 0) begin
                    currState <= B;
                    out <= 0;
                end else if (in == 1) begin
                    currState <= A;
                    out <= 0;
                end
            end
        endcase
    end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
