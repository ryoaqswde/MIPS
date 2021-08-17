module dump();

initial begin
    $shm_open("waves");
    $shm_probe(testbench.dut,"AS");
    $shm_probe(testbench,"AS");
end

endmodule

