`include "defines.v"

module ex (
    // 复位信号
    input wire rst,
    // 时钟信号
    input wire clk,
    // 运算类型
    input wire[`AluOpBus] aluop_i,
    // 运算子类型
    input wire [`AluSelBus] alusel_i,
    // 操作数1
    input wire [`RegBus] reg1_i,
    // 操作数2
    input wire [`RegBus] reg2_i,
    // 目的寄存器下标
    input wire [`RegAddrBus] wd_i,
    // 是否需要写入到寄存器中
    input wire wreg_i,
    
    // 是否需要将结果写入到寄存器 中
    output reg [`RegAddrBus] wd_o,
    // 运算结果
    output reg [`RegBus] wdata_o,
    // 写入寄存器的地址下标
    output reg wreg_o
);


// 存储运算结果
reg[`RegBus] logicount;

always @(*) begin
    // 如果是复位信号，那么设置运算结果为空即可
    if (rst === `RstEnable) begin
        logicount <= `ZeroWord;
    end
    else begin
        case (aluop_i)
            `EXE_OR_OP: begin
                logicount <= reg1_i | reg2_i
            end 
            default: begin
                logicount <= `ZeroWord
            end
        endcase
    end
end

always @(*) begin
    // 将译码阶段的寄存器设置到输出接口中
    wd_o <= wd_i;
    wreg_o <= wreg_i;

    case (alusel_i)
        // 判断运算类型，如果是逻辑运算，那么直接将运算结果设置到输出接口中
        `EXE_RES_LOGIC: begin
            wdata_o <= logicount;
        end
        default: begin
            
        end
    endcase
end
    
endmodule