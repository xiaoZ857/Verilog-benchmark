
module TopModule (
  input a,
  input b,
  input cin,
  output cout,
  output sum
);
always @(posedge clk) begin
    if (a == 1'b0 && b == 1'b0 && cin == 1'b0) begin // No carry-out
        sum <= 1'b0;
    elsif (a == 1'b1 && b == 1'b1 && cin == 1'b0) begin // Carry-out to next stage
        sum <= 1'b1;
    end else if (a == 1'b0 && b == 1'b0 && cin == 1'b1) begin // Borrow from previous stage
        sum <= 1'b1;
    elsif (a == 1'b1 && b == 1'b0 && cin == 1'b1) begin // Carry-in to current stage
        sum <= a ^ b;
    else if (a == 1'b1 && b == 1'b1 && cin == 1'b1) begin // Both carry and input are present
        sum <= ~cin | ((a & b) != 1'b0);
    end else if (a == 1'b0 && b == 1'b1 && cin == 1'b1) begin // Borrow from previous stage with carry-in
        sum <= a ^ b & ~cin;
    elsif (a == 1'b1 && b == 1'b0 && cin == 1'b1) begin // Carry-in to current stage with input being 1
        sum <= 1'b1;
    end else if (a == 1'b0 && b == 1'b1 && cin == 1'b0) begin // No borrow and no carry-in
        sum <= a ^ b & ~cin;
    elsif (a == 1'b1 && b == 1'b0 && cin == 1'b0) begin // Carry to next stage with input being 0
        sum <= 1'b0 | (a ^ b & cin);
    end else if (a == 1'b0 && b == 1'b0 && cin == 1'b0) begin // No carry and no borrow
        sum <= a & b;
    end else if (a != 1'b0 && !b && cin) begin // Carry-in to current stage with input being 0
        sum <= 1'b1 | ((a ^ b) != 1'b0);
    end else if (!a && b != 1'b0 && cin) begin // Borrow from previous stage with carry-in
        sum <= ~cin;
    end else if (a == 1'b0 && b == 1'b0 && cin) begin // Carry-in to current stage with input being 0 and carry being 1
        sum <= 1'b0;
    end else if (a != 1'b0 && !b && cin) begin // Carry-in to current stage with input being 0 and carry being 0
        sum <= a ^ b & ~cin;
    end else if (!a && b != 1'b0 && cin) begin // Borrow from previous stage with carry-in
        sum <= a ^ b & ~cin;
    end

    cout <= ~sum;
endmodule
