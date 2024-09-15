module  sram_controller (
    input clk,                // System clock
    input rst,                // Reset signal
    input read_enable,        // Signal to start a read
    input write_enable_in,    // Signal to start a write
    input [15:0] address,     // Address to read/write
    inout [7:0] data_bus,     // Bi-directional data bus
    output reg chip_enable,   // SRAM chip enable
    output reg output_enable, // SRAM output enable
    output reg write_enable_out // SRAM write enable
);
    reg [7:0] data_out;
    reg [7:0] data_in;
    reg [1:0] state;
    
    localparam IDLE  = 2'b00;
    localparam READ  = 2'b01;
    localparam WRITE = 2'b10;
    localparam WAIT  = 2'b11;
    
    assign data_bus = (write_enable_out == 1'b1) ? data_out : 8'bz; // Drive data when writing

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            chip_enable <= 1'b1;
            output_enable <= 1'b1;
            write_enable_out <= 1'b1;
        end else begin
            case (state)
                IDLE: begin
                    chip_enable <= 1'b1;
                    if (read_enable) begin
                        state <= READ;
                        chip_enable <= 1'b0;
                        output_enable <= 1'b0;
                    end else if (write_enable_in) begin
                        state <= WRITE;
                        chip_enable <= 1'b0;
                        write_enable_out <= 1'b0;
                    end
                end
                READ: begin
                    data_in <= data_bus; // Capture the data from SRAM
                    state <= WAIT;       // Wait for the read to complete
                end
                WRITE: begin
                    data_out <= data_in; // Send data to SRAM
                    state <= WAIT;       // Wait for the write to complete
                end
                WAIT: begin
                    state <= IDLE;       // Return to idle after read/write
                    chip_enable <= 1'b1;
                    output_enable <= 1'b1;
                    write_enable_out <= 1'b1;
                end
            endcase
        end
    end
endmodule
