module datapath (
    input  logic        clk, reset_n,

    input  logic        memtoreg, pcsrc,
    input  logic        alusrc, regdst,
    input  logic        regwrite, jump,
    input  logic [2:0]  alucontrol,

    output logic        zero,
    output logic [31:0] pc,
    input  logic [31:0] instr,

    output logic [31:0] aluout, writedata,
    input  logic [31:0] readdata
);

logic [4:0]  writereg ;
logic [31:0] pcnext, pcnextbr, pcplus4, pcbranch ;
logic [31:0] signimm, signimmsh ;
logic [31:0] srca, srcb ;
logic [31:0] result ;

// Next PC
always_ff @(posedge clk or negedge reset_n)
    if(!reset_n)
        pc <= 0 ;
    else
        pc <= pcnext ;

assign pcplus4 = pc + 32'h4 ;               // pcadd1
assign signimmsh = {signimm[29:0], 2'b00} ; // sl2

assign pcbranch = pcplus4 + signimmsh ;   // pcadd2

assign pcnextbr = pcsrc ? pcbranch : pcplus4 ; // pcbrmux
assign pcnext   = jump  ? {pcplus4[31:28], instr[25:0], 2'b00} : pcnextbr ; // pcmux


// Regfile
regfile regfile(
    .clk(clk),
    .we3(regwrite),
    .ra1(instr[25:21]), .ra2(instr[20:16]),
    .rd1(srca),         .rd2(writedata),
    .wa3(writereg),     .wd3(result)
);

assign writereg = regdst ? instr[15:11] : instr[20:16] ; // wrmux
assign result   = memtoreg ? readdata : aluout ;         // resmux
assign signimm  = {{16{instr[15]}}, instr[15:0]} ;       // sign extend


// ALU
assign srcb = alusrc ? signimm : writedata ;
alu #(32) alu (
    .A(srca), .B(srcb),
    .F(alucontrol),
    .Y(aluout),
    .Cout(),
    .zero(zero)
);

endmodule

