//PROCESSING ELEMENT MODULE

module pe #(parameter WIDTH = 8)
         (input clk,
          input reset,
          input clear,
          input enable,
          input [WIDTH-1 : 0] A,
          input [WIDTH-1 : 0] B,
          output [(2*WIDTH) : 0] result);

    wire [2*WIDTH : 0] acc; //extra bit for carry

    mac #(.WIDTH(WIDTH))
     mac1(.clk(clk),
          .reset(reset),
          .clear(clear),
          .enable(enable),
          .A(A),
          .B(B),
          .acc(acc));
    
    assign result = acc;

endmodule