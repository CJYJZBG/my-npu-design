`timescale 1ns/1ns
module DRU_test;   
    reg             sys_clk, clear_data_regs;   
    reg[31:0]       mem_data;   
    reg[63:0]       fb_data;   
    wire[31:0]      up_reg32_odata;   
    wire[31:0]      lo_reg32_odata;   
    wire[63:0]      reg64_odata1;   
    wire[63:0]      reg64_odata2;   
    reg             up_reg32_enable, lo_reg32_enable, reg64_enable1, reg64_enable2;   
    reg             ld_3st_cntrl, str_mux_sel, str_3st_trl;   
    always #5 sys_clk = ~sys_clk;    
        initial  fork      
        $monitor($time,,"mem_data=%d, fb_data=%d", mem_data, fb_data);    
        mem_data = 'd1024;    
        fb_data = 'd100000;    
        sys_clk = 0;    
        clear_data_regs = 0;    
        #10 clear_data_regs = 1;    
        #100 clear_data_regs = 0;    
        #500 clear_data_regs = 1;    
        #1000 clear_data_regs = 0;     
            repeat(5)     
            begin   
                #100 {up_reg32_enable, lo_reg32_enable, reg64_enable1, 
                        reg64_enable2} = 4'b1000;     
                #100 {up_reg32_enable, lo_reg32_enable, reg64_enable1, 
                        reg64_enable2} = 4'b0100; 
                #100 {up_reg32_enable, lo_reg32_enable, reg64_enable1, 
                        reg64_enable2} = 4'b0010;     
                #100 {up_reg32_enable, lo_reg32_enable, reg64_enable1, 
                        reg64_enable2} = 4'b0001;     
            end 
        $monitor($time,,"mem_data=%d, fb_data=%d", mem_data, fb_data);     
        #3000 $stop;    
        join       
    DRU dru(fb_data, up_reg32_odata, lo_reg32_odata, reg64_odata1, 
            reg64_odata2, mem_data, up_reg32_enable, lo_reg32_enable, 
            reg64_enable1, reg64_enable2, sys_clk, clear_data_regs);   
endmodule 