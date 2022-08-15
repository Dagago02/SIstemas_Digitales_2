`timescale 1ns / 1ps


module TB();

reg clk,reset,start;
reg [15:0] n;
wire [31:0] F;
//wire busy;

ParcialJunto AU(
	.clk(clk),
//	.reset(reset),
	.start(start),
	.n(n),
	.F(F)
	);
	

initial
begin
 clk = 1'b0;
 reset  = 1'b0 ;
 n=16'd8;
// reset=1;
 start=1;
end

always #5 clk = ~clk;

// Modulo initial
initial
begin
    #10;
    start=1;
	#500;
	n=16'd15;
	
	#2000
        $finish();
    end
	initial begin 
$dumpfile ("resultados.vcd");
$dumpvars;
end
    
endmodule
