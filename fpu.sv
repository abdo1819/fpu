`include "multiplier/multi.sv"
`include "adder/adder_floating_point/adder_floating_point.sv"
module fpu(
    output logic [31:0] out,  //output
    input logic [31:0] a,
    input logic [31:0] b,
    input logic [1:0] s
    );

logic [31:0] mu,ad,sb,di;


// .there(here)
multi multiplier(.a (a),.b (b),.op (mu));
adder_floating_point adder(.operand_normalized_ieee_a (a) ,
                           .operand_normalized_ieee_b (b),
                           .final_sum (ad));
adder_floating_point subtractor(.operand_normalized_ieee_a (a) ,
                           .operand_normalized_ieee_b ({~b[31],b[30:0]}),
                           .final_sum (sb));


always_comb
begin
    
    case(s)
        2'b00: out = ad;
        2'b01: out = sb;
        2'b10: out = mu;
        2'b11: out = di;
    endcase

end
endmodule
