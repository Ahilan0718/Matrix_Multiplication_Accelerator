//2X2 MATRIX MULTPLICATION ACCELERATOR TOP MODULE
module mat_accel #(parameter WIDTH = 8) (
                   input clk,
                   input reset,
                   input start,
                   input [WIDTH-1 : 0] A11,
                   input [WIDTH-1 : 0] A12,
                   input [WIDTH-1 : 0] A21,
                   input [WIDTH-1 : 0] A22,
                   input [WIDTH-1 : 0] B11,
                   input [WIDTH-1 : 0] B12,
                   input [WIDTH-1 : 0] B21,
                   input [WIDTH-1 : 0] B22,
                   output [2*WIDTH : 0] C11,
                   output [2*WIDTH : 0] C12,
                   output [2*WIDTH : 0] C21,
                   output [2*WIDTH : 0] C22,
                   output done);

    wire clear;
    wire enable;
    wire cycle_select;
    
    wire [WIDTH-1 : 0] pe0_A;
    wire [WIDTH-1 : 0] pe0_B; 
    wire [WIDTH-1 : 0] pe1_A;
    wire [WIDTH-1 : 0] pe1_B; 
    wire [WIDTH-1 : 0] pe2_A;
    wire [WIDTH-1 : 0] pe2_B; 
    wire [WIDTH-1 : 0] pe3_A;
    wire [WIDTH-1 : 0] pe3_B; 

    assign pe0_A = (cycle_select) ? A12 : A11;
    assign pe0_B = (cycle_select) ? B21 : B11;

    assign pe1_A = (cycle_select) ? A12 : A11;
    assign pe1_B = (cycle_select) ? B22 : B12;
    
    assign pe2_A = (cycle_select) ? A22 : A21;
    assign pe2_B = (cycle_select) ? B21 : B11;

    assign pe3_A = (cycle_select) ? A22 : A21;
    assign pe3_B = (cycle_select) ? B22 : B12;

    control_fsm FSM(.clk(clk),
                    .reset(reset),
                    .start(start),
                    .clear(clear),
                    .enable(enable),
                    .cycle_select(cycle_select),
                    .done(done));
    
    pe #(.WIDTH(WIDTH)) PE0(
         .clk(clk),
         .reset(reset),
         .clear(clear),
         .enable(enable),
         .A(pe0_A),
         .B(pe0_B),
         .result(C11));

    pe #(.WIDTH(WIDTH)) PE1(
         .clk(clk),
         .reset(reset),
         .clear(clear),
         .enable(enable),
         .A(pe1_A),
         .B(pe1_B),
         .result(C12));

    pe #(.WIDTH(WIDTH)) PE2(
         .clk(clk),
         .reset(reset),
         .clear(clear),
         .enable(enable),
         .A(pe2_A),
         .B(pe2_B),
         .result(C21));
    
    pe #(.WIDTH(WIDTH)) PE3(
         .clk(clk),
         .reset(reset),
         .clear(clear),
         .enable(enable),
         .A(pe3_A),
         .B(pe3_B),
         .result(C22));

endmodule

    