//CONTROL FSM MODULE

module control_fsm(input clk,
                   input reset,
                   input start,
                   output reg clear,
                   output reg enable,
                   output reg cycle_select,
                   output reg done);
    
    reg [2:0] state;
    reg [2:0] next_state;

    localparam IDLE = 3'd0;
    localparam CLEAR = 3'd1;
    localparam CYCLE1 = 3'd2;
    localparam CYCLE2 = 3'd3;
    localparam DONE = 3'd4;

    always @(posedge clk) begin

        if(reset) begin

            state <= IDLE;
        end

        else begin

            state <= next_state;
        end
    end

    always @(*) begin

        case(state)

            IDLE: begin

                if(start) begin

                    next_state = CLEAR;
                end

                else begin

                    next_state = IDLE;
                end
            end

            CLEAR: begin

                next_state = CYCLE1;
            end

            CYCLE1: begin

                next_state = CYCLE2;
            end

            CYCLE2: begin

                next_state = DONE;
            end

            DONE: begin
        
                next_state = IDLE;
            end

            default: begin

                next_state = IDLE;
            end
        endcase
    end

    always @(*) begin

        clear = 1'b0;
        enable = 1'b0;
        cycle_select = 1'b0;
        done = 1'b0;

        case(state) 

            CLEAR: begin

                clear = 1'b1;
            end

            CYCLE1: begin

                enable = 1'b1;
            end

            CYCLE2: begin

                enable = 1'b1;
                cycle_select = 1'b1;
            end

            DONE: begin

                done = 1'b1;
            end
        endcase

    end

endmodule


