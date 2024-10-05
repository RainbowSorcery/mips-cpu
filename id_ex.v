    `include "defines.v"

    module id_ex (
        // 第一个寄存器读使能信号
        input reg reg1_read_i,
        // 第二个寄存器读使能信号
        input reg reg2_read_i,
        // 第一个需要操作的寄存器下标地址
        input reg[`RegAddrBus] reg1_addr_i,
        // 第二个需要操作的寄存器下标地址
        input reg[`RegAddrBus] reg2_addr_i,

        // 译码阶段指令要进行的运算子类型，通常用于选择 ALU 的大类操作，如算术操作、逻辑操作、位移操作等。
        input reg [`AluOpBus] aluop_i,
        // 译码阶段的指令要进行的运行类型，用于告诉ALU具体执行哪种操作，例如加减乘除，异或左移等。相当于aluop是大类，alusel是aluop大类下的小类。
        input reg[`AluSelBus] alusel_i,
        // 译码阶段的源操作数1
        input reg[`RegBus] reg1_i,
        // 译码阶段的源操作数2
        input reg [`RegBus] reg2_i,
        // 译码阶段的指令要写入的目的寄存器地址
        input reg[`RegAddrBus] wd_i,
        // 译码阶段指令是否需要写入目的寄存器
        input reg wreg_i


    );
        
    endmodule