
module TopModule (
  input clk,
  input resetn,
  input x,
  input y,
  output f,
  output g
);
    reg f, g;
    reg [2:0] state, next_state;
    
    // State definitions
    localparam A = 3'd0,
               B = 3'd1,
               C = 3'd2,
               D = 3'd3,
               E = 3'd4,
               F = 3'd5,
               G = 3'd6;
    
    // State register
    always @(posedge clk) begin
        if (!resetn)
            state <= A;
        else
            state <= next_state;
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            A: next_state = (!resetn) ? A : B;
            B: next_state = C;
            C: begin
                if (x)
                    next_state = D;
                else
                    next_state = C;
            end
            D: begin
                if (!x)
                    next_state = E;
                else
                    next_state = D;
            end
            E: begin
                if (x)
                    next_state = F;
                else
                    next_state = C;
            end
            F: next_state = G;
            G: begin
                if (y)
                    next_state = G;
                else
                    next_state = F;
            end
            default: next_state = A;
        endcase
    end
    
    // Output logic
    always @(posedge clk) begin
        if (!resetn) begin
            f <= 0;
            g <= 0;
        end
        else begin
            case (state)
                A: begin
                    f <= 0;
                    g <= 0;
                end
                B: f <= 1;
                C: f <= 0;
                D: f <= 0;
                E: f <= 0;
                F: begin
                    f <= 0;
                    g <= 1;
                end
                G: g <= 1;
                default: begin
                    f <= 0;
                    g <= 0;
                end
            endcase
        end
    end
endmodule
