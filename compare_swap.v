`timescale 1ns / 1ps


module compare_swap(
input signed [31:0] V1,
input signed [31:0] V2,
input[2:0] ID1,
input[2:0] ID2,
input direction,
output reg[31:0]out1_v,
output reg[31:0]out2_v,
output reg[2:0]out1_id,
output reg[2:0]out2_id );
always @(*) begin
if (direction == 1'b0)
begin
if (V1<=V2)
begin
out1_v = V1;
out1_id = ID1;
out2_v = V2;
out2_id = ID2;
end
else begin 

out1_v = V2;
out1_id = ID2;
out2_v = V1;
out2_id = ID1;
end 
end 
else begin
if (V1>=V2)
begin
out1_v = V1;
out1_id = ID1;
out2_v = V2;
out2_id = ID2;
end 
else begin
out1_v = V2;
out1_id = ID2;
out2_v = V1;
out2_id = ID1;
end 
end 
end

endmodule
