
module TopModule (
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

reg [511:0] temp;

// Initialize all cells to 0 (off)
initial begin
    for(int i = 0; i <= 511; i++) begin
        temp[i] = 0;
    end
end

always @(posedge clk) begin
    // Load data into the system if active high load is triggered
    if(load == 1'b1) begin
        q[511:0] <= data[511:0];
    end else begin
        // If load is low, advance state of cells
        temp[512:0] = q[512:0]; // copy current state to temporary array
        for(int i = 0; i < 512; i++) begin
            int left = (i-1+511)%512;
            int center = i;
            int right = (i+1)%512;

            if(q[center] == 1'b1 && q[left] == 1'b1 && q[right] == 1'b1) begin
                temp[i] = 1'b0;
            elseif(q[center] == 1'b1 && q[left] == 1'b1) begin
                temp[i] = 1'b1;
            elseif(q[center] == 1'b1 && q[right] == 1'b1) begin
                temp[i] = 1'b1;
            elseif(q[left] == 1'b1 && q[right] == 1'b1) begin
                temp[i] = 1'b0;
            end else if(q[center] == 1'b0) begin
                temp[i] = 1'b1;
            end else begin
                temp[i] = 0;
            end
        end

        q <= temp[511:0];
    end
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
