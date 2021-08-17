module mips (
    input  logic        clk, reset_n,

    output logic [31:0] pc,
    input  logic [31:0] instr,

    output logic        memwrite,
    output logic [31:0] aluout,
    output logic [31:0] writedata,

    input  logic [31:0] readdata 
);

logic       memtoreg, alusrc, regdst, regwrite, jump, pcsrc, zero ;
logic [2:0] alucontrol ;


controller cntrl (
    .op     (instr[31:26]),
    .funct  (instr[5:0]),
    .*
);

datapath datapath (.*);

endmodule

