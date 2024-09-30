`include "defines.v"


module id (
    input wire rst,
    input wire [`InstAddrBus] pc_i,
    input wire [`InstBus] inst_i,
    input wire [`RegBus] reg1_data_i,
    input wire [`RegBus] reg2_data_i,
    output reg reg1_read_o,
    output reg reg2_read_o,
    output reg[`RegAddrBus] reg1_addr_o,
    output reg[`RegAddrBus] reg2_addr_o,

    
    output reg aluop_o[`AluOpBus],
    output reg alusel_o[`AluSelBus],
    output reg  wreg[`RegBus] reg1_o,
    output reg  wreg[`RegBus] reg2_o,
    output reg[`RegAddrBus] wd_o,
    output reg wreg_o
);
    
endmodule