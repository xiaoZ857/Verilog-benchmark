
module TopModule (
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q
);
always @(posedge clk) begin
    if(load == 1'b1) 
        q[511:0] <= data[511:0];
    else begin
        temp[512:0] = q[512:0]; // copy existing value to temporary array
        for(int i = 0; i < 512; i++) begin
            int left, center, right;
            if(i == 511) left = 510;
            else left = i-1;
            if(i == 0) right = 511;
            else right = i+1;

            temp[i] = 1'b0; // initialize with off state

            if(q[center] == 1'b1 && q[left] == 1'b1)
                temp[i] = 1'b0; 
            else if(q[center] == 1'b1 && q[right] == 1'b1) 
                temp[i] = 1'b0;
            else if (q[center] == 1'b1 && q[left] == 1'b0)
                temp[i] = 1'b1;
            else if (q[center] == 1'b1 && q[right] == 1'b0) 
                temp[i] = 1'b1;
            else if (q[left] == 1'b1 && q[right] == 1'b1)
                temp[i] = 1'b0; // left and right are on, center must be off
            else if (q[center] == 1'b0) 
                temp[i] = 1'b1;
            end
        
        q <= temp[511:0];
    end
end

// VERILOG-EVAL: endmodule not found
