// 全局宏
`define RstEnable 1'b1 // 复位信号有效
`define RstDisable 1'b0 // 复位信号无效
`define ZeroWord 32'h00000000 // 32位0
`define WriteEnable 1'b1 // 写有效
`define WriteDisable 1'b0 // 写无效
`define ReadEnable 1'b1  // 读有效
`define ReadDisable 1'b0 // 读无效
`define AluOpBus 7:0 // 译码阶段输出aluop_o的宽度
`define AluSelBus 2:0 // 译码阶段输出alusel_o的宽度
`define InstValid 1'b0 // 指令有效
`define InstInvalid 1'b1 // 指令无效
`define Stop 1'b1
`define NoStop 1'b0
`define InDelaySlot 1'b1
`define NotInDelaySlot 1'b0
`define Branch 1'b1
`define NotBranch 1'b0
`define InterruptAssert 1'b1
`define InterruptNotAssert 1'b0
`define TrapAssert 1'b1
`define TrapNotAssert 1'b0
`define True_v 1'b1 // 逻辑真
`define False_v 1'b0 // 逻辑假
`define ChipEnable 1'b1 // 芯片使能
`define ChipDisable 1'b0 // 芯片禁止


// 与具体指令集有关的宏定义
`define EXE_ORI  6'b001101 // ori指令的操作码



`define EXE_NOP 6'b000000


//AluOp 算数逻辑单元操作码 alu operator
`define EXE_OR_OP    8'b00100101
`define EXE_ORI_OP  8'b01011010


`define EXE_NOP_OP    8'b00000000

//AluSel 算数逻辑单元选择 alu select
// 逻辑运算
`define EXE_RES_LOGIC 3'b001

`define EXE_RES_NOP 3'b000


// 与rom有关的宏指令
`define InstAddrBus 31:0 // 地址总线宽度
`define InstBus 31:0 // 数据总线宽度
`define InstMemNum 131071 // rom实际大小 128K
`define InstMemNumLog2 17 // 地址线宽度


// 通用寄存器regfile有关的宏
`define RegAddrBus 4:0 // regfile模块地址线宽度
`define RegBus 31:0   // regfile数据线宽度
`define RegWidth 32   // 通用寄存器宽度
`define DoubleRegWidth 64 // 两倍通用寄存器宽度
`define DoubleRegBus 63:0 // 两倍通用寄存器数据线宽度
`define RegNum 32 // 通用寄存器的数量
`define RegNumLog2 5 // 寻址通用寄存器使用的地址位数    
`define NOPRegAddr 5'b00000
