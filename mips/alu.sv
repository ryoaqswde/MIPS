module alu #(
    parameter N = 8
)(
    input  logic [N-1:0] A, B,
    input  logic [2:0]   F,
    output logic [N-1:0] Y,
    output logic         Cout,
    output logic         zero
);

logic [N-1:0] BB ;
logic [N-1:0] S ;

assign BB = F[2] ? ~B : B ; 

adder #(N) adder(
    .a(A),
    .b(BB),
    .cin(F[2]),
    .s(S),
    .cout(Cout)
);

always_comb
    case(F[1:0])
        2'b00 : Y = A & BB ;        // and
        2'b01 : Y = A | BB ;        // or
        2'b10 : Y = S ;             // add/sub
        2'b11 : Y = {{N-1{1'b0}}, S[N-1]} ;   // compare (A<B)
    endcase

assign zero = (Y==0) ; // zero flag

endmodule

