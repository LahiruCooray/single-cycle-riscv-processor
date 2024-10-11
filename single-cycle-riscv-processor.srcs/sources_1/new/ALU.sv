module ALU (
    input logic [31:0] bus_a,       // First operand
    input logic [31:0] bus_b,       // Second operand
    input logic [3:0] ALUControl,   // Control signal
    output logic [31:0] alu_out,    // ALU result
    output logic Zero,              // Zero flag
    output logic Negative           // Negative flag
);

    always_comb begin
        case (ALUControl)
            4'b0000: alu_out = bus_a + bus_b;               // Addition
            4'b0001: alu_out = bus_a - bus_b;               // Subtraction
            4'b0010: alu_out = $unsigned(bus_a) * $unsigned(bus_b); // Unsigned multiplication
            4'b0011: alu_out = bus_a << $unsigned(bus_b);   // Logical left shift
            4'b0100: alu_out = bus_a >> $unsigned(bus_b);   // Logical right shift
            4'b0101: alu_out = bus_a >>> $unsigned(bus_b);  // Arithmetic right shift
            4'b0110: alu_out = bus_a & bus_b;               // Bitwise AND
            4'b0111: alu_out = bus_a | bus_b;               // Bitwise OR
            4'b1000: alu_out = bus_a ^ bus_b;               // Bitwise XOR
            4'b1001: alu_out = (bus_a < bus_b) ? 32'b1 : 32'b0; // Set on less than (signed)
            4'b1010: alu_out = ($unsigned(bus_a) < $unsigned(bus_b)) ? 32'b1 : 32'b0; // Set on less than (unsigned)
            4'b1011: alu_out = bus_a;                       // Output bus_a
            4'b1100: alu_out = bus_b;                       // Output bus_b
            default: alu_out = 32'b0;                       // Default to 0
        endcase
    end

    assign Zero = (alu_out == 32'b0) ? 1'b1 : 1'b0; // Zero flag
    assign Negative = (alu_out[31] == 1) ? 1'b1 : 1'b0; // Negative flag

endmodule
