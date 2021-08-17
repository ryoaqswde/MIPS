module regfile (
    input  logic        clk,

    input  logic        we3,
    input  logic [4:0]  ra1, ra2,
    output logic [31:0] rd1, rd2,

    input  logic [4:0]  wa3,
    input  logic [31:0] wd3
);

//logic [31:0] rf[31:0] ;
logic [31:0][31:0] rf ;

always_ff @(posedge clk)
    if(we3)
        rf[wa3][31:0] <= wd3 ;

assign rd1 = (ra1 != 0) ? rf[ra1][31:0] : 0 ;
assign rd2 = (ra2 != 0) ? rf[ra2][31:0] : 0 ;

endmodule

