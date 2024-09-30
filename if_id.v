`include "defines.v"

module if_id (
    // 复位信号
    input wire rst,
    // 时钟信号
    input wire clk,
    // pc传递过来的指令地址
    input wire[`InstAddrBus] if_pc,
    // rom中的指令信息
    input wire[`InstBus] if_inst,
    // 传递到译码阶段中的指令地址
    output wire[`InstAddrBus] id_pc,
    // 传递到译码阶段的指令信息
    output wire[`InstBus] id_inst
);

always @(posedge clk) begin
    // 判断是否有复位信号，如果有复位信号则直接将指令地址和指令数据设置成0表示空指令
    if (rst == `RstEnable) begin
        id_pc <= `ZeroWord;
        id_inst <= `ZeroWord;
    end else begin
        id_pc <= if_pc;
        id_inst <= if_inst;
    end
end
    
endmodule