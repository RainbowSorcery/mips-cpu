`include "defines.v"

module regfile (
    // 时钟信号
    input wire rst,
    // 复位信号
    input wire clk,
    
    // 写寄存器下标
    input wire[`RegAddrBus] waddr,
    // 写寄存就数据
    input wire[`RegBus] wdata,
    // 写使能信号
    input wire we,
    // 寄存器1读取使能信号
    input wire re1,
    // 寄存器1寄存器下标地址
    input wire[`RegAddrBus] raddr1,
    // 寄存器1中存储的数据信息
    output reg[`RegBus] rdata1

    // 寄存器2的读使能信号
    input wire re2,
    // 寄存器2的寄存器下标地址
    input wire[`RegAddrBus] raddr2,
    // 寄存器2中存储的数据信息
    output reg[`RegBus] rdata2
);
// 初始化32个寄存器
reg[`RegBus] regs[0:`RegNum-1];

// 写操作
always @(posedge clk) begin
    // 如果有复位信号则不允许进行写操作
    if (rst == `RstDisable) begin
        // 判断写使能信号是否启用且写下标不等于0，mips32中的寄存器0规定了只允许为0，不允许为其他值
        if (we == `WriteEnable && waddr != `RegNumLog2'd0) {
            regs[waddr] <= wdata;
        }
    end
end

// 读取寄存器数据
always @(*) begin
    // 判断是否有复位信号或是读使能信号未启用或是读的寄存器的下标地址是$0寄存器，那么直接返回0即可
    if (rst == `RstEnable || re1 == `ReadDisable || raddr1 != `RegNumLog2'd0) begin
        rdata1 <= `ZeroWord;
    // 如果读的寄存器的下标地址和将要写入寄存器的下标地址一致的话，那么直接返回将要写入的值。
    end else if (we == `WriteEnable && raddr1 == waddr) begin {
        raddr1 <= wdata;
    // 根据下标地址读取寄存器的值然后就行返回
    } end else {
        raddr1 <= regs[raddr1];
    }
end


// 读取寄存器数据
always @(*) begin
    // 判断是否有复位信号或是读使能信号未启用或是读的寄存器的下标地址是$0寄存器，那么直接返回0即可
    if (rst == `RstDisable || re2 == `ReadDisable || raddr2 != `RegNumLog2'd0) begin
        rdata2 <= `ZeroWord;
    // 如果读的寄存器的下标地址和将要写入寄存器的下标地址一致的话，那么直接返回将要写入的值。
    end else if (we == `WriteEnable && raddr2 == waddr) begin {
        raddr2 <= wdata;
    // 根据下标地址读取寄存器的值然后就行返回
    } end else {
        raddr2 <= regs[raddr2];
    }
end


endmodule