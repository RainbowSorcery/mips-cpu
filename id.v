`include "defines.v"


module id (
    // 复位信号
    input wire rst,
    // 指令地址
    input wire [`InstAddrBus] pc_i,
    // 指令信息
    input wire [`InstBus] inst_i,
    // 第一个操作数的寄存器读取到的数据信息
    input wire [`RegBus] reg1_data_i,
    // 第二个操作数的寄存器读取到的数据信息
    input wire [`RegBus] reg2_data_i,
    // 第一个寄存器读使能信号
    output reg reg1_read_o,
    // 第二个寄存器读使能信号
    output reg reg2_read_o,
    // 第一个需要操作的寄存器下标地址
    output reg[`RegAddrBus] reg1_addr_o,
    // 第二个需要操作的寄存器下标地址
    output reg[`RegAddrBus] reg2_addr_o,

    // 译码阶段指令要进行的运算子类型，通常用于选择 ALU 的大类操作，如算术操作、逻辑操作、位移操作等。
    output reg [`AluOpBus] aluop_o,
    // 译码阶段的指令要进行的运行类型，用于告诉ALU具体执行哪种操作，例如加减乘除，异或左移等。相当于aluop是大类，alusel是aluop大类下的小类。
    output reg[`AluSelBus] alusel_o,
    // 译码阶段的源操作数1
    output reg[`RegBus] reg1_o,
    // 译码阶段的源操作数2
    output reg [`RegBus] reg2_o,
    // 译码阶段的指令要写入的目的寄存器地址
    output reg[`RegAddrBus] wd_o,
    // 译码阶段指令是否需要写入目的寄存器
    output reg wreg_o
);
    
endmodule