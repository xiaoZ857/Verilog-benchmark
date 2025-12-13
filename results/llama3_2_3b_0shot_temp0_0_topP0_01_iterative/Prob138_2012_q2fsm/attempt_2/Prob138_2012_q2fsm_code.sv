
module TopModule (
  input clk,
  input reset,
  input w,
  output logic [1:0] z
);

// Define the states and their corresponding next-state values
typedef enum logic [1:0] {
    A, B, C, D, E, F
} states_t;

// Define the state table
always @(*) begin
    states_t next_state;
    
    // State table
    case (states)
        A(0): next_state = B;  // w -> B, reset -> A
        A(1): next_state = D;  // w -> D, reset -> A
        B(0): next_state = C;  // w -> C, reset -> D
        B(1): next_state = E;  // w -> E, reset -> D
        C(0): next_state = F;  // w -> F, reset -> C
        C(1): next_state = D;  // w -> D, reset -> C
        D(0): next_state = A;  // w -> A, reset -> F
        D(1): next_state = E;  // w -> E, reset -> F
        E(0): next_state = B;  // w -> B, reset -> E
        E(1): next_state = C;  // w -> C, reset -> E
        F(0): next_state = A;  // w -> A, reset -> D
        F(1): next_state = C;  // w -> C, reset -> D
    endcase
    
    return next_state;
end

// Define the state flip-flops
always @(posedge clk) begin
    states_t current_state;
    
    // Get the current state from the previous clock cycle
    assign current_state = states[0];
    
    // Update the state based on the current state and input w
    states_t next_state = states_table[current_state][w];
    
    // Update the state flip-flops
    states[0] <= next_state;
end

// Define the FSM output z
always @(*) begin
    logic [1:0] z_value;
    
    // Calculate the value of z based on the current state and input w
    case (states[0])
        A(0): z_value = 0;  // w -> 0, reset -> 0
        A(1): z_value = 3;  // w -> 3, reset -> 0
        B(0): z_value = 1;  // w -> 1, reset -> 0
        B(1): z_value = 4;  // w -> 4, reset -> 0
        C(0): z_value = 2;  // w -> 2, reset -> 0
        C(1): z_value = 5;  // w -> 5, reset -> 0
        D(0): z_value = 3;  // w -> 3, reset -> 0
        D(1): z_value = 4;  // w -> 4, reset -> 0
        E(0): z_value = 4;  // w -> 4, reset -> 0
        E(1): z_value = 5;  // w -> 5, reset -> 0
        F(0): z_value = 3;  // w -> 3, reset -> 0
        F(1): z_value = 5;  // w -> 5, reset -> 0
    endcase
    
    return z_value;
end

assign z = z_value;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
