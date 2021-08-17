module maindec (
    input  logic [5:0]  op,
    output logic        memtoreg, memwrite,
    output logic        branch, alusrc,
    output logic        regdst, regwrite,
    output logic        jump,
    output logic [1:0]  aluop
);

typedef enum logic [8:0] {
    RTYPE   = 9'b1100000_10 ,
    LW      = 9'b1010010_00 , // Load Word
    SW      = 9'b0010100_00 , // Set  Word
    BEQ     = 9'b0001000_01 , // Branch if equal
    ADDI    = 9'b1010000_00 , // Add immediate
    JUMP    = 9'b0000001_00 ,
    ILLEGAL = 9'bxxxxxxx_xx   //illegal operation
} assembly ;

assembly controls ;

always_comb
    case(op)
        6'b000000 : controls = RTYPE ;
        6'b100011 : controls = LW ;
        6'b101011 : controls = SW ;
        6'b000100 : controls = BEQ ;
        6'b001000 : controls = ADDI ;
        6'b000010 : controls = JUMP ;
        default   : controls = ILLEGAL ;
    endcase

assign {regwrite, regdst, alusrc, branch, memwrite, memtoreg, jump, aluop} = controls ;

endmodule

