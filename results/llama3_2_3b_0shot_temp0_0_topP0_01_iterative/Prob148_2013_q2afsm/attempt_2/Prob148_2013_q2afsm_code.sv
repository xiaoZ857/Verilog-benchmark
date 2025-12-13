
// Define the state codes
typedef enum reg ([2:0]) {
    A, B, C, D
} states;

module TopModule (
  input clk,
  input resetn,
  input [3:1] r,
  output [3:1] g
);

reg [2:0] state;
states state_code;
reg [3:0] next_state_code;

// State table
always @(*) begin
    case(state)
        A: if(r[1] == 0 && r[2] == 0) state_code = A;
            else if(r[1] == 1) state_code = B;
            else if(r[2] == 1) state_code = C;
            else state_code = D;
        B: if(r[1] == 1) state_code = B;
            else if(r[1] == 0 && r[2] == 1) state_code = A;
            else if(r[2] == 1) state_code = C;
            else state_code = B;
        C: if(r[2] == 1) state_code = C;
            else if(r[1] == 1 && r[2] == 0) state_code = A;
            else if(r[1] == 1) state_code = B;
            else state_code = C;
        D: state_code = D;
    endcase
end

// State flip-flops
always @(posedge clk or negedge resetn) begin
    if(resetn == 0) state <= A;
    else state <= next_state_code;
end

assign g[0] = (state_code == B || state_code == C);
assign g[1] = (state_code == A || state_code == C);
assign g[2] = (state_code == A || state_code == B);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
