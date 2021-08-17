module top (
    input  logic clk, reset_n,
    output logic [31:0] dataadr,
    output logic [31:0] writedata,
    output logic memwrite
);

logic [31:0] pc, instr, readdata;

mips mips(
    .aluout(dataadr),
    .*
);
imem imem(
    .a (pc[7:2]),
    .rd(instr)
);
dmem dmem(
    .clk(clk),
    .we(memwrite),
    .a (dataadr),
    .wd(writedata),
    .rd(readdata)
);

endmodule

