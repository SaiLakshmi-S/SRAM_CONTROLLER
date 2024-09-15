`include "SRAM.v"

module tb_sram_controller();

    // Testbench signals
    reg clk;
    reg rst;
    reg read_enable;
    reg write_enable_in;
    reg [15:0] address;
    wire [7:0] data_bus; // Bi-directional data bus
    reg [7:0] write_data; // Data to write
    wire chip_enable, output_enable, write_enable_out;

    // Instantiate the SRAM controller module
    sram_controller uut (
        .clk(clk),
        .rst(rst),
        .read_enable(read_enable),
        .write_enable_in(write_enable_in),
        .address(address),
        .data_bus(data_bus),
        .chip_enable(chip_enable),
        .output_enable(output_enable),
        .write_enable_out(write_enable_out)
    );

    // Assign the data bus as bi-directional
    assign data_bus = (write_enable_out == 1'b0) ? write_data : 8'bz; // Drive during write

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end
    initial 
    begin
        $dumpfile("dump.vcd");
        $dumpvars(0,tb_sram_controller);
    end


    // Testbench procedure
    initial begin
        // Initialize inputs
        rst = 1;  // Reset active
        read_enable = 0;
        write_enable_in = 0;
        address = 16'h0000;
        write_data = 8'h00;

        // Release reset
        #10 rst = 0;

        // Write operation
        #10;
        address = 16'h0010;  // Write to address 0x0010
        write_data = 8'hAA;  // Write data 0xAA
        write_enable_in = 1'b1; // Enable write
        #10 write_enable_in = 1'b0; // Disable write after a short delay

        // Read operation
        #20;
        read_enable = 1'b1;  // Enable read
        address = 16'h0010;  // Read from address 0x0010
        #10 read_enable = 1'b0; // Disable read after a short delay

        // Finish simulation
        #30 $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time: %0dns, Address: %h, Data Bus: %h, Chip Enable: %b, Output Enable: %b, Write Enable: %b", 
                 $time, address, data_bus, chip_enable, output_enable, write_enable_out);
    end

endmodule