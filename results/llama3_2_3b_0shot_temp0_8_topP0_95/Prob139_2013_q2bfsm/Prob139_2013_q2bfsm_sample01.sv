
module TopModule(
  input clk, // Positive clock edge
  input resetn, // Active low reset
  input x,     // Input from motor
  input y,     // Input from motor
  output f,    // Output to control motor
  output g      // Output to control motor
);

// Reset state (state A)
localreg [1:0] state = 2'b00;

// Internal signals for states
localreg [1:0] nextState = 2'b00;
localreg [3:2] cycleCountX = 2'b00;
localreg regWaitX = 2'b00;
localreg regWaitY = 2'b00;

// State transitions and output assignments
always @(posedge clk orposedge resetn) begin

  // Reset state
  if (!resetn) begin
    state <= 2'b00;
    cycleCountX <= 2'b00;
    regWaitX <= 2'b00;
    regWaitY <= 2'b00;
  end else begin

    // Monitor x until values 1,0,1 in three successive clock cycles
    if (regWaitX == 2'b00) begin
      cycleCountX <= cycleCountX + 1;
      if (cycleCountX < 3) regWaitX <= 2'b01;
      else if (cycleCountX > 3) regWaitX <= 2'b10;
    end

    // Check for values 1,0,1 in x
    if ((cycleCountX == 3'b011) && (!x)) begin
      nextState <= 2'b01; // Move to state B with g=0
    end else if (state == 2'b00 && cycleCountX != 3'b001) begin
      nextState <= 2'b10; // Move to state C with regWaitY = 1
    end

    // Transition from state A to state B
    if (nextState == 2'b01) begin
      f <= 1;
      nextState <= 2'b00;
      cycleCountX <= 2'b00;
      regWaitX <= 2'b00;
    end else if (state == 2'b10 && regWaitY == 2'b10) begin // Move to state C
      g <= 1;
      nextState <= 2'b11; // Wait for y=1 or two cycles, then set g=0
    end

    // Monitor y in state B and C
    if (state == 2'b01 || state == 2'b11) begin
      if (y) regWaitY <= 2'b10;
      else if (regWaitY != 2'b10 && regWaitX != 2'b00) g <= 0;
    end

    // Update state and cycle counts
    if (state == 2'b01 || state == 2'b11) begin
      nextState <= nextState + 1;
      if (nextState < 3) nextState <= 3'b011;
      else nextState <= 3'b000;
    end

    // Transition from states B to C and set output f in state A
    if (state == 2'b01 && regWaitX != 2'b00) begin
      nextState <= 2'b11; // Wait for y=1 or two cycles, then set g=0
    end else if (state == 2'b10 || state == 2'b11) begin
      f <= 0;
      nextState <= 2'b00; // Reset cycle count and wait signal
    end

    // Update output assignments for current state
    if (nextState != 3'b011 && (x == 1)) f <= 1;
    else f <= 0;

    // Output assignment for g
    if (state == 2'b11) begin
      if (y == 1 || regWaitY != 2'b10)
        g <= 1;
      else
        g <= 0;
    end

    // Reset signal edge (reset state after four clock edges from resetn going low)
    if (!resetn && (~resetn & ~regWaitX) && (~resetn & ~regWaitY)) begin
      state <= 2'b00;
      cycleCountX <= 2'b00;
      regWaitX <= 2'b00;
      regWaitY <= 2'b00;
    end

  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
