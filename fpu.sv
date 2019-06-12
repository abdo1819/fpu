`include "multiplier/multi.sv"
`include "adder/adder_floating_point/adder_floating_point.sv"
`include "divider/FPU_division.sv"


module fpu(input logic [1:0] funct ,input logic clk  ,input logic [31:0] a,b, output logic[31:0] o);
  reg [31:0] o1; 
  reg fin1;
  reg zero1;
  reg ov1 ,und1;
  reg funct1;
  reg [31:0] o2;
  reg fin2;
  reg [31:0] o3;
  
  adder_floating_point a1(a,b, //opreands must be enterd normalized
  o1 ,//result
  fin1 ,//flag of finish
  //flags
 zero1 ,
 over1,

 und1,
 funct1//selector for adding operand a + or - operand b
);
FPU_division f(clk,a,b,o2,fin2);
multi m(o3,a,b);
always@(posedge clk, funct[0])
case(funct[0])
0:funct1=0;
1:funct1=1;

default:funct1=1'bz;
endcase
always@(negedge clk, funct,a,b,fin1,fin2,funct1)
case(funct)
0:o=o1;
1:o=o1;
2:
if (fin2==1)
o=o2;
else o=32'bz;
3:o=o3;
default:o=32'bz;
endcase
endmodule
