//CONTROL FSM TB

module controller_test;

reg clk;
reg reset;
reg start;

wire clear;
wire enable;
wire cycle_select;
wire done;

control_fsm uut(.clk(clk),
                .reset(reset),
                .start(start),
                .clear(clear),
                .enable(enable),
                .cycle_select(cycle_select),
                .done(done));
    
    always #5 clk = ~clk;

    task check_output;

        input check_clear;
        input check_enable;
        input check_cycle_select;
        input check_done;

    begin

        #1;
        if((clear == check_clear) && (enable == check_enable) && (cycle_select == check_cycle_select) && (done == check_done)) begin

            $display("PASS");
        end

        else begin

            $display("FAIL");
        end
    end
    endtask

    initial begin

        clk = 1'b0;
        reset = 1'b1;
        start = 1'b0;
        #10;

        reset = 1'b0;
        check_output(0,0,0,0);

        start = 1'b1;

        @(posedge clk) 
        check_output(1,0,0,0);

        start = 1'b0;

        @(posedge clk) 
        check_output(0,1,0,0);

        @(posedge clk)
        check_output(0,1,1,0);

        @(posedge clk)
        check_output(0,0,0,1);

        @(posedge clk) 
        check_output(0,0,0,0);

        #20;
        $finish;
    end

endmodule
