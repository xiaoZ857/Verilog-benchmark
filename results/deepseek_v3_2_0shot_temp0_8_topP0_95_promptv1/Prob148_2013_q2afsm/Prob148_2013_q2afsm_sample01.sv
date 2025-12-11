
module TopModule (
  input clk,
  input resetn,
  input [3:1] r,
  output [3:1] g
);
always @(posedge clk) begin
    if (!resetn) begin
        state <= A;
    end
    else begin
        case (state)
            A: begin
                if (r[1]) begin
                    state <= B;
                end
                else if (r[2]) begin
                    state <= C;
                end
                else if (r[3]) begin
                    state <= D;
                end
                else begin
                    state <= A;
                end
            end
            B: begin
                if (r[1]) begin
                    state <= B;
                end
                else begin
                    state <= A;
                end
            end
            C: begin
                if (r[2]) begin
                    state <= C;
                end
                else begin
                    state <= A;
                end
            end
            D: begin
                if (r[3]) begin
                    state <= D;
                end
                else begin
                    state <= A;
                end
            end
            default: state <= A;
        endcase
    end
end

always @(*) begin
    g = 3'b000;
    case (state)
        B: g[1] = 1'b1;
        C: g[2] = 1'b1;
        D: g[3] = 1'b1;
        default: g = 3'b000;
    endcase
end

localparam A = 2'b00,
           B = 2'b01,
           C = 2'b10,
           D = 2'b11;

reg [1:0] state;

endmodule
