
module TopModule (
  input clk,
  input reset,
  input data,
  output start_shifting
);
reg [1:0] state;
reg [2:0] shift_count; // Number of bits to shift
reg start_shifting;

initial state = START;
initial shift_count = 0;
initial start_shifting = 0;

always @(posedge clk) begin
    if (reset) begin
        state <= START;
        shift_count <= 0;
        start_shifting <= 0;
    end else begin
        case(state)
            START:
                if (data == 1) begin // Shift '1'
                    state <= SEARCH_01;
                else if (data == 0) begin // Shift '0'
                    state <= SEARCH_00;
                end
            SEARCH_00:
                if (data == 0) begin // Found '0' in sequence
                    state <= FOUND_00;
                else if (data == 1) begin // Not found '0', continue searching
                    state <= SEARCH_00;
                end
            SEARCH_01:
                if (data == 1) begin // Found '1' in sequence
                    state <= FOUND_11;
                else if (data == 0) begin // Not found '1', continue searching
                    state <= SEARCH_01;
                end
            FOUND_11:
                if (data == 1) begin // Shift '1'
                    shift_count <= shift_count + 1;
                    state <= FOUND_10;
                else if (data == 0) begin // Not found '1', reset sequence
                    state <= START;
                end
            FOUND_10:
                if (data == 0) begin // Found '0' in sequence
                    state <= FOUND_01;
                else if (data == 1) begin // Not found '0', continue searching
                    state <= FOUND_10;
                end
            FOUND_01:
                if (data == 0) begin // Shift '0'
                    shift_count <= shift_count + 1;
                    state <= FOUND_00;
                else if (data == 1) begin // Not found '0', reset sequence
                    state <= START;
                end
            FOUND_00:
                start_shifting <= 1; // Found complete sequence, set start_shifting to 1
        endcase
    end
endmodule
