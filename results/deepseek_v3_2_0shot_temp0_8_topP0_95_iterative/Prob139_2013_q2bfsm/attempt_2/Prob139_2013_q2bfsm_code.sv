
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
    reg [1:0] y_counter;  // Counter for monitoring y
    
    // State definitions
    localparam A = 3'd0,
               B = 3'd1,
               C = 3'd2,
               D = 3'd3,
               E = 3'd4,
               F = 3'd5,
               G = 3'd6,
               H = 3'd7;  // Added state for permanent g=1
    
    // State register
    always @(posedge clk) begin
        if (!resetn) begin
            state <= A;
            y_counter <= 2'd0;
        end
        else begin
            state <= next_state;
            // Update y counter when in state G
            if (state == G) begin
                if (y_counter < 2'd2) begin
                    y_counter <= y_counter + 1;
                end
            end
            else begin
                y_counter <= 2'd0;
            end
        end
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
            F: next_state = G;  // State where we set g=1
            G: begin
                // Check if y=1 within 2 clock cycles
                if (y)
                    next_state = H;  // Permanent g=1
                else if (y_counter == 2'd2)
                    next_state = A;  // Go back to A with g=0
                else
                    next_state = G;  // Keep monitoring y
            end
            H: next_state = H;  // Permanent state, stay here until reset
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
                B: f <= 1;  // Set f=1 for one clock cycle
                C: f <= 0;
                D: f <= 0;
                E: f <= 0;
                F: begin
                    f <= 0;
                    g <= 0;  // g=0 here, will be set to 1 in next state
                end
                G: begin
                    f <= 0;
                    g <= 1;  // Set g=1 after detecting sequence
                end
                H: begin
                    f <= 0;
                    g <= 1;  // Permanent g=1
                end
                default: begin
                    f <= 0;
                    g <= 0;
                end
            endcase
        end
    end
endmodule
