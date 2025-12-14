
// Verilog Module for 100-bit Rotator with Synchronous Load and Left/Right Enable

module TopModule (
    input clk,             // Clock
    input load,             // Load control signal
    input [1:0] ena,         // Rotation enable (2'b01 for right rotation, 
                             // 2'b10 for left rotation, 2'b00 and 2'b11 do not rotate)
    input [99:0] data_in,   // Data to load into the rotator
    output reg [99:0] q     // Contents of the rotator after each clock cycle
);

// Signals to store current state of rotator
reg [99:0] r1;
reg [99:0] r2;

// Signal to control direction of data transfer
wire [99:0] shift_dir;

// Module instance for left shift register
TopRotatorModule LShift Reg(
    .clk(clk),
    .load(load),
    .ena(ena[1:0]),
    .data(data_in[99:1]), // Shift data into rotator from right end
    .q(LShift.r2)       // Left shifted-out bit to be fed into left register
);

// Module instance for right shift register
TopRotatorModule RShift Reg(
    .clk(clk),
    .load(load),
    .ena(ena[1:0]),
    .data(data_in[99:1]), // Shift data into rotator from left end
    .q(RShift.r1)       // Right shifted-out bit to be fed into right register
);

// Direction of shift control 
assign shift_dir = !ena[1] ? data_in[99:0] : data_in[1:0]; // If ena[1] is 1, the direction becomes right

// Write left shifted out value into left reg and right shifted out value to right reg
assign LShift.r2 = r1;
assign RShift.r1 = r2;

initial begin
    // Initialize r1 with shift direction
    $resetforAlways r1 = shift_dir;
    
    // Initialize r2 with data loaded from registers
    $resetforAlways r2 = data_in;
end

// Main logic to generate rotated bits
assign q = (ena[0] ? shift_dir : r1);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
