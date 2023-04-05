module LUT6_NAND(
    input control,
    input in_sig,
    output out_sig
    );
// LUT6: 6-Bit Look-Up Table
//       UltraScale
// Xilinx HDL Language Template, version 2022.1

LUT6 #(
 .INIT(64'h00000000AAAAAAAA) // Arash: This should make an inverter
) LUT6_inst (
 .O(out_sig), // LUT general output
 .I0(control), // LUT input
 .I1(0'b0), // LUT input
 .I2(0'b0), // LUT input
 .I3(0'b0), // LUT input
 .I4(0'b0), // LUT input
 .I5(in_sig) // LUT input
);
// End of LUT6_inst instantiation
endmodule