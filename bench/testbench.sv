module testbench();

logic clk, reset_n ;
logic [31:0] dataadr ;
logic [31:0] writedata ;
logic memwrite ;


// DUT
top dut(.*);

// Reset
initial begin
    reset_n = 0 ;
    #22 ;
    reset_n = 1 ;
end

// Clock
initial begin
    clk = 0 ;
    forever begin
        #5 ;
        clk = ~clk ;
    end
end

// Check
always @(negedge clk)
    begin
        if(memwrite) begin
            if(dataadr===84 & writedata===7) begin
                $display("Simulation succeeded.");
                $stop;
            end else if(dataadr!==80) begin
                $display("Simulation failed.");
                $stop;
            end
        end
    end

endmodule
