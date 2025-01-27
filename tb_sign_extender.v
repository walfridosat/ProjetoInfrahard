module tb_sign_extender16_32;
    reg [15:0]data;
    wire [31:0]data_extended;

    sign_extender16_32 extendedor (
        .data(data),
        .data_extended(data_extended)
    );

    initial begin
      data = 16'b0110010101001100;
      #10;
      $display("%b",data_extended);
      #10;
      data = 16'b1010110011001100;
      #10;
      $display("%b",data_extended);
    end
endmodule

module tb_sign_extender1_32;
    reg data;
    wire [31:0]data_extended;

    sign_extender1_32 extendedor (
        .data(data),
        .data_extended(data_extended)
    );

    initial begin
      data = 1'b0;
      #10;
      $display("%b",data_extended);
      #10;
      data = 1'b1;
      #10;
      $display("%b",data_extended);
    end
endmodule
