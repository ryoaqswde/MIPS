module aludec (
    input  logic [5:0]  funct,
    input  logic [1:0]  aluop,

    output logic [2:0]  alucontrol
);

typedef enum logic [2:0] {
    ADD = 3'b010 ,
    SUB = 3'b110 ,
    AND = 3'b000 ,
    OR  = 3'b001 ,
    SLT = 3'b111 ,
    XXX = 3'bxxx 
} function_tipe ;

function_tipe alucontrol_state ;

always_comb
    case(aluop)
        2'b00 : alucontrol_state = ADD ; // lw/sw/addi
        2'b01 : alucontrol_state = SUB ; // beq
        default :
            case(funct)
                6'b100000 : alucontrol_state = ADD ;
                6'b100010 : alucontrol_state = SUB ;
                6'b100100 : alucontrol_state = AND ;
                6'b100101 : alucontrol_state = OR  ;
                6'b101010 : alucontrol_state = SLT ;
                default   : alucontrol_state = XXX ;
            endcase
    endcase

assign alucontrol = alucontrol_state ;

endmodule

