//2X2 MATRIX MULTIPLICATION ACCELERATOR TB
`timescale 1ns/1ps
module mat_accel_test;

parameter WIDTH = 8;

reg clk;
reg reset;
reg start;
reg [WIDTH-1 : 0] A11;
reg [WIDTH-1 : 0] A12;
reg [WIDTH-1 : 0] A21;
reg [WIDTH-1 : 0] A22;
reg [WIDTH-1 : 0] B11;
reg [WIDTH-1 : 0] B12;
reg [WIDTH-1 : 0] B21;
reg [WIDTH-1 : 0] B22;

wire [2*WIDTH : 0] C11;
wire [2*WIDTH : 0] C12;
wire [2*WIDTH : 0] C21;
wire [2*WIDTH : 0] C22;
wire done;

mat_accel #(.WIDTH(WIDTH)) uut(
            .clk(clk),
            .reset(reset),
            .start(start),
            .A11(A11),
            .A12(A12),
            .A21(A21),
            .A22(A22),
            .B11(B11),
            .B12(B12),
            .B21(B21),
            .B22(B22),
            .C11(C11),
            .C12(C12),
            .C21(C21),
            .C22(C22),
            .done(done));

    always #5 clk = ~clk;

    task check_top;

        input [16:0] check_C11;
        input [16:0] check_C12;
        input [16:0] check_C21;
        input [16:0] check_C22;

    begin

        #1;
        if((C11 == check_C11) && (C12 == check_C12) && (C21 == check_C21) && (C22 == check_C22)) begin

            $display("PASS : C11 = %d, C12 = %d, C21 = %d, C22 = %d", check_C11, check_C12, check_C21, check_C22);
        end
        
        else begin

            $display("FAIL");
        end
    end
    endtask
 
    initial begin

        $dumpfile("dump_top.vcd");
        $dumpvars(0, mat_accel_test);
        
        clk = 1'b0;
        reset = 1'b1;
        start = 0;

        A11 = 8'd1;
        A12 = 8'd2;
        A21 = 8'd3;
        A22 = 8'd4;
        B11 = 8'd5;
        B12 = 8'd6;
        B21 = 8'd7;
        B22 = 8'd8;

        #15;

        reset = 0;

        @(posedge clk) 

        start = 1'b1;

        @(posedge clk)

        start = 1'b0;

        wait(done);

        check_top(19,22,43,50);

        #20;
        $finish;
    end

endmodule

    
    


