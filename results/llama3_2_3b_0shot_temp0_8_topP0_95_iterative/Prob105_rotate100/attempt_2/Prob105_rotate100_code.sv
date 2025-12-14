
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

// Module instance for left shift register
TopRotatorModule LShift Reg(
    .clk(clk),
    .load(load),
    .ena(ena[1:0]),
    .data(data_in[99:0]), // Shift data into rotator from right end
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
assign r1 = (load ? data_in : !ena[1] ? r2 : 0);
assign RShift.r1 = r1;
assign r2 = (load ? data_in[99:0] : !ena[1] ? r1 : 0);
assign LShift.r2 = r2;

initial begin
    // Initialize r1 with shift direction
    $resetforAlways r1 = data_in; // load is active high
    
end

// Main logic to generate rotated bits
assign q = (ena[0] ? r1 : !ena[1] ? r2 : 0);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
