`include "multiplier/multi.sv"

module fpu(
    output logic [31:0] op,  //O/P
    input logic [31:0] a,
    input logic [31:0] b,
    input logic [1:0] s
    );

logic [31:0] mu,ad,su,di;


multi m(.a (a),.b (b),.op (mu));
// .there(here)
always_comb
begin
    
    case(s)
        2'b00: op = mu;
        2'b01: op = mu;
        2'b10: op = mu;
        2'b11: op = mu;
    endcase

end
endmodule
