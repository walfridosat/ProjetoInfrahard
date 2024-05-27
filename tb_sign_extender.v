module tb_sign_extender;
    reg data;
    reg data_extended;

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