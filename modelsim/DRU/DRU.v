module 
DRU(fb_data, up_reg32_odata, lo_reg32_odata, reg64_odata1, 
    reg64_odata2, mem_data, up_reg32_enable, lo_reg32_enable,
    reg64_enable1, reg64_enable2, sys_clk, clear_data_regs);

input           sys_clk;
input           clear_data_regs;
input           up_reg32_enable, lo_reg32_enable;
input           reg64_enable1, reg64_enable2;
input[31:0]     mem_data;
input[63:0]     fb_data;
output[31:0]    up_reg32_odata, lo_reg32_odata;
output[63:0]    reg64_odata1, reg64_odata2;
wire            sys_clk, clear_data_regs;
wire[31:0]      mem_data;
wire[63:0]      fb_data;
reg[31:0]       up_reg32_odata;
reg[31:0]       lo_reg32_odata;
wire            up_reg32_enable;
wire            lo_reg32_enable;
wire            ld_3st_cntrl;
reg[63:0]       reg64_odata1;
reg[63:0]       reg64_odata2;
wire            reg64_enable1;
wire            reg64_enable2;
wire            str_mux_sel;
wire            str_3st_cntrl;
integer         i;

always@(posedge sys_clk)
if(clear_data_regs)
    begin
        for( i=0; i<32; i=i+1)
            begin
                up_reg32_odata[i] = 0;
                lo_reg32_odata[i] = 0;   
            end
        for ( i=0; i<64; i=i+1)
            begin
                reg64_odata1[i] = 0;
                reg64_odata2[i] = 0;
            end
    end
else
    begin
        if(up_reg32_enable == 1)
            up_reg32_odata <= mem_data;
        else if(lo_reg32_enable == 1)
            lo_reg32_odata <= mem_data;
        else if(reg64_enable1 == 1)
            reg64_odata1 <= fb_data;
        else if(reg64_enable2 == 1)
            reg64_odata2 <= fb_data;
    end
endmodule