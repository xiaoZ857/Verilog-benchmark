
module TopModule (
  input clk,
  input areset,

  input predict_valid,
  input [6:0] predict_pc,
  output predict_taken,
  output [6:0] predict_history,

  input train_valid,
  input train_taken,
  input train_mispredicted,
  input [6:0] train_history,
  input [6:0] train_pc
);

  // Internal registers and signals
  reg [6:0] global_history;
  reg [1:0] pht [0:127];  // 128-entry 2-bit saturating counter table
  
  // Internal signals for prediction
  wire [6:0] predict_index;
  wire [1:0] predict_counter;
  
  // Internal signals for training
  wire [6:0] train_index;
  wire [1:0] train_counter;
  reg [1:0] new_counter_value;
  
  // Calculate indices using XOR
  assign predict_index = predict_pc ^ global_history;
  assign train_index = train_pc ^ train_history;
  
  // Read PHT entries
  assign predict_counter = pht[predict_index];
  assign train_counter = pht[train_index];
  
  // Determine prediction from 2-bit counter
  assign predict_taken = predict_counter[1];  // MSB indicates taken
  
  // Output current history for prediction
  assign predict_history = global_history;
  
  // Calculate new counter value for training
  always @(*) begin
    if (train_valid) begin
      if (train_taken) begin
        // Increment counter (saturating at 11)
        case (train_counter)
          2'b00: new_counter_value = 2'b01;
          2'b01: new_counter_value = 2'b10;
          2'b10: new_counter_value = 2'b11;
          2'b11: new_counter_value = 2'b11;
        endcase
      end else begin
        // Decrement counter (saturating at 00)
        case (train_counter)
          2'b00: new_counter_value = 2'b00;
          2'b01: new_counter_value = 2'b00;
          2'b10: new_counter_value = 2'b01;
          2'b11: new_counter_value = 2'b10;
        endcase
      end
    end else begin
      new_counter_value = train_counter;
    end
  end
  
  // Initialize PHT
  integer i;
  initial begin
    for (i = 0; i < 128; i = i + 1) begin
      pht[i] = 2'b00;
   

// VERILOG-EVAL: endmodule not found
