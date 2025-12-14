
module TopModule (
  input clk,
  input reset,
  output shift_ena
);
reg counter = 3'b000; // Counter to keep track of 4-cycle window
reg shift_ena; // Signal for enabling the shift register

always @(posedge clk) begin
    if (reset) // On reset, shift enable for 4 cycles
        shift_ena <= 1'b1;
    else if (counter >= 4'b0100) // If counter exceeds 4, keep shift enable off
        shift_ena <= 1'b0;
    else begin // Increment counter and check for the proper bit pattern
        counter <= counter + 1;
        shift_ena <= (counter == 3'b011) ? 1'b1 : 1'b0; // Enable shift register when proper pattern detected
    end
end

// Reset synchronization
always @(posedge clk negedge reset) begin
    if (reset)
        counter <= 3'b000;
end

// Add missing clock edge sensitivity if necessary (optional, depending on simulation tool)
initial begin
    #1 always @(posedge clk); // Sensitivity list for always blocks: clk is specified here
end

assign shift_ena = shift_ena; // Assign output signal to internal 'shift_ena'

endmodule
