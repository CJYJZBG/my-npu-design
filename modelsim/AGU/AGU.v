module
    AGU( mem_gen_oaddr, byte_gen_oaddr, fb_gen_oaddr, rc_gen_oaddr,
                latch_tr_addresses, latch_tr_control, mem_gen_ldinit, 
                mem_gen_enable, byte_gen_ldinit, byte_gen_enable, 
                fb_gen_enable, rc_gen_ldinit, rc_gen_enable, sys_clk, clear_agu);

    input           clear_agu, sys_clk; 
    input[39:0]     latch_tr_addresses;  
    input[3:0]      latch_tr_control;   
    input           mem_gen_ldinit, mem_gen_enable, byte_gen_ldinit;  
    input           byte_gen_enable, fb_gen_enable, rc_gen_ldinit;  
    input           rc_gen_enable;   
    output[15:0]    mem_gen_oaddr;   
    output[15:0]    byte_gen_oaddr;   
    output[5:0]     fb_gen_oaddr;   
    output[7:0]     rc_gen_oaddr;   
    wire[39:0]      latch_tr_addresses; 
    wire[3:0]       latch_tr_control;   
    wire            clear_agu,sys_clk; 
    wire            mem_gen_ldinit, mem_gen_enable; 
    wire            byte_gen_ldinit, byte_gen_enable; 
    wire            fb_gen_ldinit, fb_gen_enable;
    wire            rc_gen_ldinit, rc_gen_enable; 
    reg[15:0]       mem_gen_oaddr;   
    reg[15:0]       byte_gen_oaddr;   
    reg[5:0]        fb_gen_oaddr;   
    reg[7:0]        rc_gen_oaddr;   
    integer         i;   

    always@(posedge sys_clk)    
        if(clear_agu == 1)     
            begin     
                for( i=0; i<16; i=i+1)      
                    begin      
                        mem_gen_oaddr[i] = 0;      
                        byte_gen_oaddr[i] = 0;      
                    end      
                rc_gen_oaddr <= 8'b00000000;      
                fb_gen_oaddr <= 6'b000000;     
            end    
        else 
            if(byte_gen_ldinit == 1)      
                if(latch_tr_control[1] == 1)      
                    byte_gen_oaddr <= latch_tr_addresses[23:8];      
                else        
                    byte_gen_oaddr[15:0] <= {latch_tr_addresses[21:8], 2'b00};
            else if(byte_gen_enable == 1) 
                byte_gen_oaddr <= byte_gen_oaddr + 15'b000_0000_0000_0001;     
            else if(rc_gen_ldinit == 1)      
                rc_gen_oaddr <= latch_tr_addresses[7:0];     
            else if(rc_gen_enable == 1)      
                rc_gen_oaddr <= rc_gen_oaddr + 8'b0000_0001;     
            else if(mem_gen_ldinit == 1)      
                mem_gen_oaddr <= latch_tr_addresses[39:24];     
            else if(mem_gen_enable == 1) 
                mem_gen_oaddr <= mem_gen_oaddr + 15'b000_0000_0000_0001;     
            else if(fb_gen_enable == 1)                
                fb_gen_oaddr <= fb_gen_oaddr + 6'b000001; 
endmodule 