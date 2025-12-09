

module TopModule (
  input clk,
  input in,
  input reset,
  output out
);

always @(*) begin
    // Define the states and their corresponding next states
    assign out = $signed({0, 0, 0, 1}[in]);
    
    // State transition table
    case(out)
        0: 
            if(in == 0) out = 0;
            else out = 1;
        1: 
            if(in == 0) out = 2;
            else out = 3;
        
        default:
            $fatal_error("Invalid state value");
    endcase
endmodule
