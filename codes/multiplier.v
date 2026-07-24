//MULTIPLIER MODULE 

module multiplier #(parameter WIDTH = 8) (
                    input [WIDTH-1 : 0] A,
                    input [WIDTH-1 : 0] B,
                    output [(2*WIDTH)-1 : 0] product);
    
    assign product = A * B;

endmodule