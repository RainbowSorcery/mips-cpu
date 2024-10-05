`include "defines.v"

module id_ex (
    // 复位信号
    input wire rst,
    // 时钟信号
    input wire clk,
    // 译码阶段指令要进行的运算子类型，通常用于选择 ALU 的大类操作，如算术操作、逻辑操作、位移操作等。
    input wire [`AluOpBus] id_aluop,
    // 译码阶段的指令要进行的运行类型，用于告诉ALU具体执行哪种操作，例如加减乘除，异或左移等。相当于aluop是大类，alusel是aluop大类下的小类。
    input wire[`AluSelBus] id_alusel,
        // 译码阶段的源操作数1
    input wire[`RegBus] id_reg1,
    // 译码阶段的源操作数2
    input wire [`RegBus] id_reg2,
    // 译码阶段的指令要写入的目的寄存器地址
    input wire[`RegAddrBus] id_wd,
    // 译码阶段指令是否需要写入目的寄存器
    input wire id_wreg

    // 译码阶段指令要进行的运算子类型，通常用于选择 ALU 的大类操作，如算术操作、逻辑操作、位移操作等。
    output reg [`AluOpBus] ex_aluop,
    // 译码阶段的指令要进行的运行类型，用于告诉ALU具体执行哪种操作，例如加减乘除，异或左移等。相当于aluop是大类，alusel是aluop大类下的小类。
    output reg[`AluSelBus] ex_alusel,
        // 译码阶段的源操作数1
    output reg[`RegBus] ex_reg1,
    // 译码阶段的源操作数2
    output reg [`RegBus] ex_reg2,
    // 译码阶段的指令要写入的目的寄存器地址
    output reg[`RegAddrBus] ex_wd,
    // 译码阶段指令是否需要写入目的寄存器
    output reg ex_wreg

);

always @(posedge clk) begin
    // 判断是否在复位，如果在复位则返回空指令
    if (rst === `RstEnable) begin
        ex_aluop <= `EXE_RES_NOP;
        ex_alusel <= `EXE_RES_NOP;
        ex_reg1 <= `ZeroWord;
        ex_reg2 <= `ZeroWord;
        ex_wd <= `NOPRegAddr;
        ex_wreg <= `WriteDisable;

    end else begin
    // 将信息在下一个时钟周期发送到执行模块中
    ex_aluop <= id_aluop;
    ex_alusel <= id_alusel;
    ex_reg1 <= id_reg1;
    ex_reg2 <= id_reg2;
    ex_wd <= id_wd;
    ex_wreg <= id_wreg;
    end

end


        
endmodule