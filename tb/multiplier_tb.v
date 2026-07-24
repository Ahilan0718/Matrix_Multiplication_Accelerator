//MULTIPLIER TB

module multi_test;

parameter WIDTH = 8;

reg [WIDTH-1 : 0] A;
reg [WIDTH-1 : 0] B;

wire [(2*WIDTH)-1 : 0] product;

multiplier #(.WIDTH(WIDTH)) 
               DUT(
                   .A(A),
                   .B(B),
                   .product(product));

    initial begin

        $dumpfile("dump_multi.vcd");
        $dumpvars(0, multi_test);

        $monitor("TIME: %0t, A: %d, B: %d, PRODUCT: %d", $time, A, B, product);

        A = 8'd0;
        B = 8'd0;
        #10;

        A = 8'd5;
        B = 8'd4;
        #10;

        A = 8'd12;
        B = 8'd10;
        #10;

        A = 8'd20;
        B = 8'd10;
        #10;

        A = 8'd255;
        B = 8'd255;
        #30;

        $finish;
    end
endmodule



