//MULTIPLIER-ACCUMULATOR MODULE

module mac #(parameter WIDTH = 8)(
             input clk,
             input reset,
             input clear,
             input enable,
             input [WIDTH-1 : 0] A,
             input [WIDTH-1 : 0] B,
             output reg [2*WIDTH : 0] acc);

    wire [(2*WIDTH)-1 : 0] product;

    multiplier #(.WIDTH(WIDTH))
           MULTI(.A(A),
                 .B(B),
                 .product(product));

    always @(posedge clk) begin

        if(reset) begin

            acc <= 0;
        end

        else if(clear) begin //if clear is HIGH, then clear accumulator

            acc <= 0;
        end

        else if(enable) begin //if enable is HIGH, then acculmulate the products

            acc <= acc + product;
        end
    end

endmodule
    
