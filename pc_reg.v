`include "defines.v"

module pc_reg (
    // 时钟信号
    input wire rst,
    // 复位信号
    input wire clk,
    // 指令地址
    output reg [`InstAddrBus] pc,
    // rom使能信号
    output wire ce
);  

// 当时钟
always @(posedge clk) begin
    if (rst == `RstEnable) begin
        ce <= `ChipDisable
    end else begin
        ce <= `ChipEnable
    end
end
    
always @(posedge clk) begin
    if (ce == `ChipDisable) begin
        pc <= 32'h00000000;
    end else begin
        pc <= pc + 4'h4;
    end
end
endmodule