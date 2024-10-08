module ex_em (
    // 复位信号
    input wire rst,
    // 时钟信号
    input wire clk,
        

    // 执行阶段要写入的目的寄存器地址
    input wire [`RegAddrBus] ex_wd,
    // 执行阶段要写入的数据
    input wire [`RegBus] ex_wdata,
    // 执行阶段是否写入到寄存器中
    input wire ex_wreg,
    
    // 访存阶段要写入的目的寄存器地址
    input wire [`RegAddrBus] mem_wd,
    // 访存阶段要写入的数据
    input wire [`RegBus] mem_wdata,
    // 访存阶段是否写入到寄存器中
    input wire mem_wreg
);
    always @(posedge clk) begin
        // 判断是否有复位信号 如果有则设置一些初始值 否则在下一个时钟周期将执行阶段的数据发送到访存阶段中
        if (rst === `RstEnable) begin
            mem_wd <= `NOPRegAddr;
            mem_wdata <= `ZeroWord;
            mem_wreg <= `ReadDisable; 
        end else begin
            mem_wd <= ex_wd;
            mem_wdata <= ex_wdata;
            mem_wreg <= ex_wreg
        end
    end
endmodule