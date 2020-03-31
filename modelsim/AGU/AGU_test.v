`timescale 1ns/1ns
module AGU_test;   
    reg[39:0]       latch_tr_addresses;   
    reg[3:0]        latch_tr_control;   
    reg             clear_agu, sys_clk;   
    reg             mem_gen_ldinit, mem_gen_enable;   
    reg             byte_gen_ldinit, byte_gen_enable;   
    reg             fb_gen_ldinit, fb_gen_enable;   
    reg             rc_gen_ldinit, rc_gen_enable;   
    wire[15:0]      mem_gen_oaddr; 
    wire[15:0]      byte_gen_oaddr;   
    wire[5:0]       fb_gen_oaddr;   
    wire[7:0]       rc_gen_oaddr;
    integer         i;

    always #5 sys_clk = ~sys_clk;
    initial begin
    latch_tr_addresses = 102400;
    latch_tr_control = 4'b0010;
    sys_clk = 0;
    clear_agu = 0;
    {mem_gen_ldinit, mem_gen_enable, byte_gen_ldinit, byte_gen_enable,
            fb_gen_enable, rc_gen_ldinit, rc_gen_enable} = 7'b0000000;
    #10 clear_agu = 1;
    #10 clear_agu = 0;    
    #20 begin     
            for( i=0; i<128; i=i+1)     
            #10 {mem_gen_ldinit, mem_gen_enable, byte_gen_ldinit, byte_gen_enable,
                    fb_gen_enable, rc_gen_ldinit, rc_gen_enable} = {mem_gen_ldinit, 
                    mem_gen_enable, byte_gen_ldinit, byte_gen_enable, fb_gen_enable, 
                    rc_gen_ldinit, rc_gen_enable} + 1;     
        end    
    #2000 $stop;    
    end    
    AGU     AGU(mem_gen_oaddr, byte_gen_oaddr, fb_gen_oaddr, rc_gen_oaddr,
            latch_tr_addresses, latch_tr_control, mem_gen_ldinit, mem_gen_enable,
            byte_gen_ldinit, byte_gen_enable, fb_gen_enable, rc_gen_ldinit, rc_gen_enable,
            sys_clk, clear_agu);   
endmodule 