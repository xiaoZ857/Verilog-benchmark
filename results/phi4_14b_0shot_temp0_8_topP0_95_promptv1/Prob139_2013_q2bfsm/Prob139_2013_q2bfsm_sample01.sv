
module TopModule (
  input clk,
  input resetn,
  input x,
  input y,
  output f,
  output g
);
reg [2:0] state, next_state;
assign f = (state == 1);
always @(posedge clk or negedge resetn) begin
    if (!resetn)
        state <= 3'b000; // State A
    else
        state <= next_state;
end

wire x_abc_detected;
reg [1:0] x_counter, next_x_counter;

assign x_abc_detected = (x_counter == 2'b11);

always @(posedge clk) begin
    if (state != 3'b001) // Reset counter when not in the correct state
        x_counter <= 2'b00;
    else
        x_counter <= next_x_counter;
end

always @(*) begin
    case (x)
        1'b1: next_x_counter = x_counter + 1;
        1'b0: next_x_counter = (x_counter == 2'b10) ? 2'b01 : 0;
        default: next_x_counter = 0;
    endcase
end

wire g_activate;
assign g_activate = (state == 3'b010 && x_abc_detected);

reg [1:0] y_counter, next_y_counter;

always @(posedge clk) begin
    if (g_activate)
        y_counter <= next_y_counter;
end

always @(*) begin
    case ({g_activate, y})
        {1'b1, 1'b1}: next_y_counter = 2'b00; // Reset on detecting 'y'
        1'b0: next_y_counter = 0;
        default: next_y_counter = (y_counter == 2'b10) ? 2'b01 : y_counter + 1;
    endcase
end

wire g_set, g_reset;
assign g_set = (state == 3'b010 && x_abc_detected);
assign g_reset = (!g_activate && y_counter == 2'b10);

always @(posedge clk) begin
    if (!resetn)
        g <= 1'b0;
    else if (g_set)
        g <= 1'b1;
    else if (g_reset)
        g <= 1'b0;
end

always @(*) begin
    case (state)
        3'b000: next_state = resetn ? 3'b001 : 3'b000; // State A to B on reset de-assertion
        3'b001: next_state = 3'b010; // Move to state C after setting f
        3'b010: begin
            if (g_set)
                next_state = 3'b011;
            else if (!x_abc_detected && x_counter == 2'b00) 
                next_state = 3'b000; // Return to state A if sequence not detected
            else
                next_state = 3'b010;
        end
        3'b011: next_state = 3'b011; // Stay in State D once g is set
        default: next_state = 3'b000;
    endcase
end

endmodule
