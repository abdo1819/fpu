`include "multiplier/multi.sv"
`include "adder/adder_floating_point/adder_floating_point.sv"
`include "divider/FPU_division.sv"
module fpu(input logic clk,
           input logic [1:0] funct ,       
           input logic [31:0] a,b, 
           output logic[31:0] o,
           output logic finish);

//add an internal clk
//DO NOT USE THIS CODE IN THE ORIGINAL PROJECT IT WAS INTENDED TO BE INTERNAL AND IT SHOULDN'T
    logic clk_div ;
    reg [31:0] o1,o2,o3; 
    reg fin1,fin2,fin3;
    reg zero1;
    reg ov1 ,und1;
    reg funct1;

always 
    begin
        clk_div =1; #2; clk_div = 0; #2;
    end



           adder_floating_point a1(clk_div,a,b, //opreands must be enterd normalized
                            o1 ,//result
                            fin1 ,//flag of finish
                            //flags
                            zero1 ,over1,und1,
                            funct[0]//selector for adding operand a + or - operand b
                            );
    
    FPU_division f(clk_div,a,b,o2,fin2);
    
    multi m(clk,o3,a,b,fin3);

    
    always_comb
    begin
        case(funct)
            0: finish =fin1;
            1: finish =fin1;
            2: finish =fin2;
            3: finish =fin3;
            endcase
    end


    always_comb
    begin
        case(funct)
            0:o=o1;
            1:o=o1;
            2:o=o2;
            3:o=o3;
        default: o=32'bz;
        endcase
    end
    endmodule
