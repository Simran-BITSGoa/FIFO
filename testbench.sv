`timescale 1ns/1ps

module fifo_testbench;

    import "DPI-C" function void request_packet(output byte pkt[10]);

    logic write_clk = 0, read_clk = 0, rst = 1;
    logic write_en = 0, read_en = 0;
    logic [79:0] data_in, data_out;
    logic full, empty;
    string read_str;

    // Instantiate FIFO
    fifo1 #(.DSIZE(80), .ASIZE(6)) fifo_inst (
        .wclk(write_clk),
        .rclk(read_clk),
        .wrst_n(~rst),
        .rrst_n(~rst),
        .winc(write_en),
        .rinc(read_en),
        .wdata(data_in),
        .rdata(data_out),
        .wfull(full),
        .rempty(empty)
    );

    // Clock Generation
    always #5 write_clk = ~write_clk;
    always #7 read_clk = ~read_clk;

    initial begin
        #20 rst = 0;  // Deassert reset

        fork
            // Continuous Packet Writing
            begin
                forever begin
                    byte pkt[10];
                    request_packet(pkt);
                    
                    // Display received packet before writing
                    $write("[TB] Generated Packet: ");
                    foreach (pkt[i]) $write("%s", pkt[i]);
                    $display("");
                    
                    // Convert byte array to 80-bit logic
                    data_in = 0;
                    for (int j = 0; j < 10; j++) begin
                        data_in[j*8 +: 8] = pkt[j];  
                    end

                    if (!full) begin
                        write_en = 1;
                        #10 write_en = 0;
                    end
                    #20;
                end
            end

            // Continuous Packet Reading
            begin
                forever begin
                    if (!empty) begin
                        read_en = 1;
                        #10 read_en = 0;
                        #20;

                        // Convert 80-bit logic to string
                        read_str = "";
                        for (int i = 0; i < 10; i++) begin
                            read_str = {read_str, data_out[i*8 +: 8]};
                        end
                        $display("[TB] Read Data: %s", read_str);
                    end
                    #10;
                end
            end
        join_none

        #30000;
        $display("[TB] Simulation stopped after 30000 ns.");
        disable fork;
        $finish;
    end

endmodule

