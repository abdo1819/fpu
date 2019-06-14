module test();

    reg clk;
    reg [31:0] a,b,opexp;
    logic [31:0] op;
    reg [31:0] vectornum,errors;
    reg [99:0] testvectors[1000:0];
    logic [1:0] funct; 
    logic [1:0] dommy;

    logic finish;

    logic compare;
    shortreal opr;
    shortreal opexpr;
    shortreal diff;

fpu f(.clk,.funct,.a,.b,.o (op),.finish);

always 
    begin
        clk =1; #210; clk = 0; #200;
    end

initial begin
    $readmemh("fpu.tv", testvectors);
    vectornum = 0; errors = 0;
end

always @(posedge clk)
    begin
        {dommy,funct,a,b,opexp} = testvectors[vectornum];
    end
logic [29:0]dum; 
logic [29:0]dum2; 
always @(posedge finish ,negedge clk)
    begin
        #10;
        opr = $bitstoshortreal(op);
        opexpr = $bitstoshortreal(opexp);
        diff = opr-opexpr;
        // if(diff < 0)
        //     diff = diff * -1;
        //     // dum = op[30:1];
        // dum2 = opexp[30:1];
        if  ( (opr != opexpr) & ~( (opr-opexpr < 0.01)&(opexpr-opr > -0.01) ) )

            begin
                $display("operation  = %b ",funct);
                
                $display("input = %h __ %h",a,b);
                $display("input = %f __ %f",$bitstoshortreal(a),$bitstoshortreal(b));
                $display("a = %b\nb = %b",a,b);

                $display("output = %h  __ %f",op ,opr);
                $display("exp    = %h  __ %f\n",opexp ,opexpr);	
                errors = errors+1;
            end
        vectornum = vectornum +1;

        if(testvectors[vectornum] ===100'bx) begin
            $display("%d test complate with %d errors" , vectornum , errors);
            vectornum = vectornum -1;
            $stop();
        end
    end

    
endmodule
