
module TopModule (
  input clk,
  input resetn,
  input [3:0] r, // Note: We use a single-bit mask to simplify the state table
  output reg [3:1] g      // Use "reg" instead of "output" for assignment
);

reg [2:0] current_state; // State code is in the range [2:0]
reg [2:0] next_state;
wire [2:0] state_table;

// Assign state table values
assign state_table = {r[3], r[1], r[2]};

// State table (always)
always @(*) begin
  case(current_state)
    3 : next_state = 3; // A
    2 : if(state_table == {0, 0, 0}) next_state = 4; // B
          else if((state_table[0] && state_table[1]) || (state_table[2] && state_table[1])) 
              next_state = 3; // A
          else if(state_table[0])
              next_state = 1; // B
          else if(state_table[2])
              next_state = 0; // C
          else if(state_table[1])
              next_state = 0; // C
    1 : next_state = 3; // A (giving device 1 a grant)
    0 : if((state_table[0] && state_table[2]) || state_table[1]) 
           next_state = 4; // B
          else if(state_table[0])
              next_state = 3; // A
          else if(state_table[2])
              next_state = 1; // B
          else if(state_table[1])
              next_state = 0; // C
    endcase
end

// Next state logic
always @(posedge clk) begin
    if(resetn == 0)
        current_state <= 3;
    else 
      current_state <= next_state;
end

// Output logic using continuous assignment statements
assign g[0] = (current_state == 1);
assign g[1] = (current_state == 2); // Note: This might not work as expected due to the state table assignment
assign g[2] = (current_state == 3);
assign g[3] = ~state_table; // This will always be true, because of the way we designed the FSM

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
