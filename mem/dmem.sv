module dmem (
    input  logic        clk,

    input  logic        we,
    input  logic [31:0] a,
    input  logic [31:0] wd,
    output logic [31:0] rd
);

logic [63:0][31:0] RAM ;


always_ff @(posedge clk)
    if(we)
        RAM[a[31:2]][31:0] <= wd ;

assign rd = RAM[a[31:2]][31:0] ;

// debug
logic [63:0] add ;
assign add = a[31:2] ;

endmodule

