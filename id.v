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

// 在I型指令中，16位位宽没办法存储32位的地址长度，所以需要扩展成32位才能操作内存地址，所以立即数imm为32位。
reg [`RegBus] imm;

// 指令是否可用
reg instValid = `InstInvalid;

// 获取操作码  ori是I型指令，它的操作码在26-31位上
reg [5:0] op = inst_i[31:26];

// 解析指令信息
always @(*) begin
    // 如果在复位，那么将立即数以及输出接口的数据全部设置成不可用的值
    if (rst === `RstEnable) begin
        reg1_read_o <= `ReadDisable;
        reg2_read_o <= `ReadDisable;
        reg1_addr_o <= `ZeroWord;
        reg2_addr_o <= `ZeroWord;
        aluop_o <= `EXE_RES_NOP;
        alusel_o <= `EXE_NOP_OP;
        reg1_o <= `ZeroWord; 
        reg2_o <= `ZeroWord;
        wd_o  <= `NOPRegAddr;
        wreg_o <= `WriteDisable;
        imm <= 32`h0;
    end else begin
        // 根据操作码来确定要执行的译码操作
        case (op)
            `EXE_ORI: begin
                // 需要将或运算结果写回到寄存器中
                wd_o <= `WriteEnable;
                // 运算子类型为或运算
                aluop_o <= `EXE_OR_OP;
                // 运算类型为逻辑运算
                alusel_o <= `EXE_RES_LOGIC;
                // 需要读取两个寄存器的操作数来进行或运算
                reg1_read_o <= `ReadEnable;
                reg2_read_o <= `ReadEnable;

                // ORI指令是I类型指令，imm存储在指令的0-15位中，下面的语句将前16位设置成0，后十六位设置为立即数
                imm <= {16`h0, inst_i[15:0]};
                wd_o <= inst_i[20:16];
                
                // 指令有效
                instValid = `InstValid;

            end 
            default: 
        endcase 
    end
end

// 获取寄存器传递过来的数据并发送到ID/EX模块中
always @(*) begin
     // 如果复位信号 那么直接返回空指令
    if (rst === `RstEnable) begin
        reg1_o <= `ZeroWord;  
    // 如果寄存器中的数据可读，那么直接返回寄存器的数据
    end else if (reg1_read_o === `ReadEnable) begin 
        reg1_o <= reg1_data_i;
    // 否则直接返回imm立即数
    end else if (reg1_read_o === `ReadDisable) begin
        reg1_o <= imm;
    end else begin
        reg1_o <= `ZeroWord;
    end
end

// 获取寄存器传递过来的数据并发送到ID/EX模块中
always @(*) begin
     // 如果复位信号 那么直接返回空指令
    if (rst === `RstEnable) begin
        reg21_o <= `ZeroWord;  
    // 如果寄存器中的数据可读，那么直接返回寄存器的数据
    end else if (reg2_read_o === `ReadEnable) begin 
        reg2_o <= reg2_data_i;
    // 否则直接返回imm立即数
    end else if (reg2_read_o === `ReadDisable) begin
        reg2_o <= imm;
    end else begin
        reg2_o <= `ZeroWord;
    end
end



endmodule