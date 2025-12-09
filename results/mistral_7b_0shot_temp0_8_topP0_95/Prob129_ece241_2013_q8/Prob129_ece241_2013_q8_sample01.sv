
module TopModule (
  input clk,
  input aresetn,
  input x,
  output reg z
);

reg [2:0] state; // 3 states for the FSM
 always @(posedge clk) begin
   if (!aresetn) begin
     state <= 0;
     z <= 0;
   end
   else begin
     case (state)
       0: begin
         if (x == 1) state <= 1;
         else state <= 0;
         z <= 0;
       end
       1: begin
         if (x == 0) state <= 2;
         else state <= 1;
         z <= 0;
       end
       2: begin
         if (x == 1) state <= 3;
         else if (x == 0) state <= 0; // Reset the state if an incorrect bit is received
         if (x == 1 && state == 2) z <= 1; // Assert z when "101" sequence is detected
       end
       3: begin
         if (x == 0) state <= 0; // Reset the state if an incorrect bit is received
       end
     endcase
   end
 end
endmodule

// VERILOG-EVAL: errant inclusion of module definition
