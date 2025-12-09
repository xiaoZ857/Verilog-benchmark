
module TopModule (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  input ground,
  input dig,
  output walk_left,
  output walk_right,
  output aaah,
  output digging
);
We need to model the behavior with a Moore FSM. The outputs depend only on the current state.  
The key is to handle priorities:  
1. **Fall** (ground=0) has highest priority.  
2. **Dig** (dig=1 and ground=1 and not falling) is next.  
3. **Switch directions** due to bump is lowest priority, and only when walking (not falling, not digging).  

Also:  
- Bump while falling/digging has no effect.  
- Dig when falling or no ground is ignored.  
- When ground=0, the Lemming falls (aaah=1) and remembers the last walking direction.  
- When ground reappears (ground=1) while falling, resume walking in that remembered direction.  
- Digging continues until ground=0, then fall, then resume walking in original direction.  

Let¡¯s define states:  
We need to track both behavior mode (walk_left, walk_right, fall_left, fall_right, dig_left, dig_right) and direction (left or right) for fall/dig states.  

But simpler:  
We can encode state as {mode[1:0], dir} where:  
mode: 00=WALK, 01=FALL, 10=DIG  
dir: 0=left, 1=right  

But in Moore, outputs:  
walk_left = (mode==WALK && dir==0)  
walk_right = (mode==WALK && dir==1)  
aaah = (mode==FALL)  
digging = (mode==DIG)  

Transitions:  
- Reset: mode=WALK, dir=0 (walk_left).  
- If mode==WALK:  
  - If ground==0 ¡ú mode=FALL, keep dir.  
  - Else if dig==1 ¡ú mode=DIG, keep dir.  
  - Else if bump_left ¡ú dir=1 (right), mode stays WALK.  
  - Else if bump_right ¡ú dir=0 (left), mode stays WALK.  
  - Else stay.  
- If mode==FALL:  
  - If ground==1 ¡ú mode=WALK, keep dir.  
  - Else stay FALL.  
- If mode==DIG:  
  - If ground==0 ¡ú mode=FALL, keep dir.  
  - Else stay DIG.  

Note: In WALK, if bump_left and bump_right both 1, we switch dir (so if dir=0 ¡ú dir=1, if dir=1 ¡ú dir=0).  

Let¡¯s implement with state register [2:0]:  
state[1:0] = mode (00:WALK, 01:FALL, 10:DIG)  
state[2] = dir (0:left, 1:right)  

We¡¯ll compute next_state.  

  reg [2:0] state, next_state;
  localparam WALK = 2'b00, FALL = 2'b01, DIG = 2'b10;
  localparam LEFT = 1'b0, RIGHT = 1'b1;
  
  // state[1:0] = mode, state[2] = dir
  
  always @(*) begin
    case (state[1:0])
      WALK: begin
        if (~ground) begin
          next_state[1:0] = FALL;
          next_state[2] = state[2];
        end else if (dig) begin
          next_state[1:0] = DIG;
          next_state[2] = state[2];
        end else begin
          next_state[1:0] = WALK;
          // bump logic
          if (bump_left & ~bump_right)
            next_state[2] = RIGHT;
          else if (bump_right & ~bump_left)
            next_state[2] = LEFT;
          else if (bump_left & bump_right)
            next_state[2] = ~state[2];
          else
            next_state[2] = state[2];
        end
      end
      FALL: begin
        if (ground) begin
          next_state[1:0] = WALK;
          next_state[2] = state[2];
        end else begin
          next_state[1:0] = FALL;
          next_state[2] = state[2];
        end
      end
      DIG: begin
        if (~ground) begin
          next_state[1:0] = FALL;
          next_state[2] = state[2];
        end else begin
          next_state[1:0] = DIG;
          next_state[2] = state[2];
        end
      end
      default: begin
        next_state = state;
      end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
