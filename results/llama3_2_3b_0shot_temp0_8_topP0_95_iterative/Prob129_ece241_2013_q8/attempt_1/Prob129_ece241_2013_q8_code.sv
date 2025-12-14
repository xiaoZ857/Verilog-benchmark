
module TopModule (
  input clk,
  input aresetn,
  input x,
  output reg z
);
module MealyFSM(clk, aresetn, x, z);

    // Define the states of the finite state machine
    parameter [0:1] ST_IDLE = 2'b00;
    parameter [0:1] ST Seq1 = 2'b01;
    parameter [0:1] ST(Seq1 | Seq101) = 2'b10;

    // Define the next state and output values for each input signal
    reg [0:1] st;
    reg z_value;

    always @(posedge clk or negedge aresetn) begin
        if (~aresetn)
            st <= ST_IDLE;
        else if (posedge clk)
            st <= STIdle;
        else if (x == 1 && st == ST_Idle)
            st <= ST Seq1;
        else if (x == 0 && st == ST_Seq1)
            st <= ST(Seq1 | Seq101);
        // The sequence is detected, but we're still processing it
        else if (x == 1 && st == ST_Seq101)
            st <= ST(Seq1 | Seq101);
        else if (x == 0 && st == ST_Seq101)
            z_value <= 1;
        else if (x == 1 && st == ST_Seq101)
            z_value <= 1;
        else
            st <= ST_Idle;
    end

    assign z = z_value;

endmodule
