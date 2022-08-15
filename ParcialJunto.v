`timescale 1ns / 1ps


module ParcialJunto(
    input clk,
	input start,
	input  [15:0] n,	
	output reg [31:0]F
	
	
    );
    
	reg n1,n2,n3,n4,y1,y2,z1,z2,f1;
	reg [15:0] N;
	reg [15:0] Y;
	reg [31:0] Z;
	
	always @(*) 
	begin 
		if(presente==S1)
			N <= n;
		else
			N <=N;
	end

///////////////////////////////////////////////////////maquina de estados////////////////////////////////////////////////////////
    parameter S1  = 3'd0;
    parameter S2 = 3'd1;
    parameter S3 = 3'd2;
	parameter S4  = 3'd3;
	parameter S5  = 3'd4;
	parameter S6  = 3'd5;
	parameter S7  = 3'd6;
	parameter S8  = 3'd7;

    reg [2:0] presente = S1; // Registro de Estado - Valor inicial
    reg [2:0] futuro;            // Entrada del registro de Estado

    // Registro de estado 
    always @(posedge clk)
        presente <= futuro;

    // Lógica del estado siguiente
    always @(*)
        case (presente)
            S1:
                if(start==1 && N>3)
                    futuro <= S2;
                else if(start==1 && N<=3)
                    futuro <= S8;
				else
					futuro <= S1;
            S2:                
                futuro <= S3;
            S3:
				if(N!=3 && N<3)
					futuro <= S4;
				else if(N!=3 && N>3)
                    futuro <= S3;
				else if(N==3)
					futuro <= S6;
			S4:                
                futuro <= S5;
			S5:
                if(N!=5 && N>5)
                    futuro <= S5;
                else if(N!=5 && N<5)
                    futuro <= S7;
				else if(N==5)
					futuro <= S6;
			S6:
				if(Y!=3)
					futuro <= S7;
				else if(Y==3)
                    futuro <= S8;
			S7:                
                futuro <= S2;
			S8:                
                futuro <= S1;
            default:
                futuro <= S1;
        endcase
    
    // Lógica de salida
    always @(presente)
        case (presente)
            S1 : begin
                n1 <= 1'b0;
                n2 <= 1'b1;
                n3 <= 1'b1;
                n4 <= 1'b1;
                y1 <= 1'b1;
				y2 <= 1'b1;
				z1 <= 1'b1;
				z2 <= 1'b1;
				f1 <= 1'b0;
            end
            S2 : begin
                n1 <= 1'b1;
                n2 <= 1'b0;
                n3 <= 1'b1;
                n4 <= 1'b1;
                y1 <= 1'b1;
				y2 <= 1'b0;
				z1 <= 1'b0;
				z2 <= 1'b1;
				f1 <= 1'b0;
            end
            S3 : begin
                n1 <= 1'b1;
                n2 <= 1'b1;
                n3 <= 1'b0;
                n4 <= 1'b1;
                y1 <= 1'b0;
				y2 <= 1'b1;
				z1 <= 1'b0;
				z2 <= 1'b1;
				f1 <= 1'b0;
            end
			S4 : begin
                n1 <= 1'b1;
                n2 <= 1'b1;
                n3 <= 1'b1;
                n4 <= 1'b1;
                y1 <= 1'b0;
				y2 <= 1'b1;
				z1 <= 1'b0;
				z2 <= 1'b1;
				f1 <= 1'b0;
            end
			S5 : begin
                n1 <= 1'b1;
                n2 <= 1'b1;
                n3 <= 1'b1;
                n4 <= 1'b0;
                y1 <= 1'b0;
				y2 <= 1'b1;
				z1 <= 1'b0;
				z2 <= 1'b1;
				f1 <= 1'b0;
            end
			S6 : begin
                n1 <= 1'b0;
                n2 <= 1'b1;
                n3 <= 1'b1;
                n4 <= 1'b1;
                y1 <= 1'b0;
				y2 <= 1'b1;
				z1 <= 1'b1;
				z2 <= 1'b0;
				f1 <= 1'b0;
            end
			S7 : begin
                n1 <= 1'b1;
                n2 <= 1'b1;
                n3 <= 1'b1;
                n4 <= 1'b1;
                y1 <= 1'b0;
				y2 <= 1'b1;
				z1 <= 1'b0;
				z2 <= 1'b1;
				f1 <= 1'b0;
            end
			S8 : begin
                n1 <= 1'b0;
                n2 <= 1'b1;
                n3 <= 1'b1;
                n4 <= 1'b1;
                y1 <= 1'b0;
				y2 <= 1'b1;
				z1 <= 1'b0;
				z2 <= 1'b1;
				f1 <= 1'b1;
            end
            default: begin
                n1 <= 1'b0;
                n2 <= 1'b1;
                n3 <= 1'b1;
                n4 <= 1'b1;
                y1 <= 1'b1;
				y2 <= 1'b1;
				z1 <= 1'b1;
				z2 <= 1'b1;
				f1 <= 1'b0;
            end
        endcase
///////////////////////////////////////////////////////datapath//////////////////////////////////////////////////////////////////
// 1 0
    wire [15:0] nextN1;
    wire [15:0] nextN2;
	wire [15:0] nextN3;
	wire [15:0] nextN4;
	wire [15:0] nextY1;
	wire [15:0] nextY2;
	wire [31:0] nextZ1;
	wire [31:0] nextZ2;
	wire [15:0] nextF1;
	
	    
    // Registro N
    always @(posedge clk)
       N <= nextN1;
    
	assign nextN4 = (n4)? Y:N-16'd5;
	assign nextN3 = (n3)? nextN4:N-16'd3;
	assign nextN2 = (n2)? nextN3:N-16'd1;
    assign nextN1 = (n1)? nextN2:N;	
	     
    // Registro Y
    always @(posedge clk)
        Y <= nextY1;
    
	assign nextY2 = (y2)? n:N-16'd1;
    assign nextY1 = (y1)? nextY2:Y;
		
	//Registro Z
	always @(posedge clk)
        Z <= nextZ1;
		
	assign nextZ2 = (z2)? 31'd0:Z+Y;
    assign nextZ1 = (z1)? nextZ2:Z;
	
    //Registro F
	always @(posedge clk)
        F <= nextF1;
		
	assign nextF1 = (f1)? Z:F;   




    
endmodule
