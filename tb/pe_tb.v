//PROCESSING ELEMENT TB

module pe_test;

parameter WIDTH = 8;

reg clk;
reg reset;
reg clear;
reg enable;
reg [WIDTH-1 : 0] A;
reg [WIDTH-1 : 0] B;

wire [2*WIDTH : 0] result;

pe #(.WIDTH(WIDTH)) 
  DUT(.clk(clk),
      .reset(reset),
      .clear(clear),
      .enable(enable),
      .A(A),
      .B(B),
      .result(result));

always #5 clk = ~clk;

task result_clear;
begin

    enable = 1'b0;
    clear = 1'b1;

    @(posedge clk)

        #1;
        clear = 1'b0;
    end
endtask

task pe_test;

    input [7:0] a;
    input [7:0] b;
    input [16:0] out;

begin

    A = a;
    B = b;

    enable = 1;

    @(posedge clk) 

        #1;

        if(result == out) begin

            $display("PASS: RESULT = %d", result);
        end

        else begin

            $display("FAIL: expected = %d, got = %d", out, result);
        end
        enable = 1'b0;

    end
endtask

initial begin

    clk = 1'b0;
    reset = 1'b1;
    clear = 1'b0;
    enable = 1'b0;
    A = 8'd0;
    B = 8'd0;
    #10;

    reset = 1'b0;
    clear = 1'b1;

    @(posedge clk) 

    result_clear();

    pe_test(5,4,20);
    pe_test(2,3,26);
    pe_test(10,10,126);

    result_clear();

    pe_test(7,2,14);

    #20;
    $finish;
end

endmodule



