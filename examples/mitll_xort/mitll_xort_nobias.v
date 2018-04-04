// ---------------------------------------------------------------------------
// Automatically extracted verilog file, created with TimEx v2.00.14
// Timing description and structural design for IARPA-BAA-14-03 via
// U.S. Air Force Research Laboratory contract FA8750-15-C-0203 and
// IARPA-BAA-16-03 via U.S. Army Research Office grant W911NF-17-1-0120.
// For questions about TimEx, contact CJ Fourie, coenrad@sun.ac.za
// (c) 2016-2018 Stellenbosch University
// ---------------------------------------------------------------------------
`timescale 1ps/100fs
module mitll_xort (a, b, clk, out);

input
  a, b, clk;

output
  out;

reg
  out;

real
  delay_state1_clk_out = 9.5,
  delay_state2_clk_out = 9.5,
  ct_state0_a_a = 10.4,
  ct_state0_b_b = 10.4,
  ct_state0_clk_a = 0.4,
  ct_state0_clk_b = 0.4,
  ct_state1_a_b = 13.0,
  ct_state1_a_clk = 9.6,
  ct_state1_b_b = 4.4,
  ct_state1_clk_b = 7.0,
  ct_state2_a_a = 4.4,
  ct_state2_b_a = 13.1,
  ct_state2_b_clk = 9.6,
  ct_state2_clk_a = 7.0;

reg
   errorsignal_a,
   errorsignal_b,
   errorsignal_clk;

integer
   outfile,
   cell_state; // internal state of the cell

initial
   begin
      errorsignal_a = 0;
      errorsignal_b = 0;
      errorsignal_clk = 0;
      cell_state = 0; // Startup state
      out = 0; // All outputs start at 0
   end

always @(posedge a or negedge a) // execute at positive and negative edges of input
   begin
      if ($time>4) // arbitrary steady-state time)
         begin
            if (errorsignal_a == 1'b1)  // A critical timing is active for this input
               begin
                  outfile = $fopen("errors.txt", "a");
                  $fdisplay(outfile, "Violation of critical timing in module %m; %0d ps.\n", $stime);
                  $fclose(outfile);
                  out <= 1'bX;  // Set all outputs to unknown
               end
            if (errorsignal_a == 0)
               begin
                  case (cell_state)
                     0: begin
                           cell_state = 1;  // Blocking statement -- immediately
                           errorsignal_a = 1;  // Critical timing on this input; assign immediately
                           errorsignal_a <= #(ct_state0_a_a) 0;  // Clear error signal after critical timing expires
                        end
                     1: begin
                           errorsignal_b = 1;  // Critical timing on this input; assign immediately
                           errorsignal_b <= #(ct_state1_a_b) 0;  // Clear error signal after critical timing expires
                           errorsignal_clk = 1;  // Critical timing on this input; assign immediately
                           errorsignal_clk <= #(ct_state1_a_clk) 0;  // Clear error signal after critical timing expires
                        end
                     2: begin
                           cell_state = 0;  // Blocking statement -- immediately
                           errorsignal_a = 1;  // Critical timing on this input; assign immediately
                           errorsignal_a <= #(ct_state2_a_a) 0;  // Clear error signal after critical timing expires
                        end
                  endcase
               end
         end
   end

always @(posedge b or negedge b) // execute at positive and negative edges of input
   begin
      if ($time>4) // arbitrary steady-state time)
         begin
            if (errorsignal_b == 1'b1)  // A critical timing is active for this input
               begin
                  outfile = $fopen("errors.txt", "a");
                  $fdisplay(outfile, "Violation of critical timing in module %m; %0d ps.\n", $stime);
                  $fclose(outfile);
                  out <= 1'bX;  // Set all outputs to unknown
               end
            if (errorsignal_b == 0)
               begin
                  case (cell_state)
                     0: begin
                           cell_state = 2;  // Blocking statement -- immediately
                           errorsignal_b = 1;  // Critical timing on this input; assign immediately
                           errorsignal_b <= #(ct_state0_b_b) 0;  // Clear error signal after critical timing expires
                        end
                     1: begin
                           cell_state = 0;  // Blocking statement -- immediately
                           errorsignal_b = 1;  // Critical timing on this input; assign immediately
                           errorsignal_b <= #(ct_state1_b_b) 0;  // Clear error signal after critical timing expires
                        end
                     2: begin
                           errorsignal_a = 1;  // Critical timing on this input; assign immediately
                           errorsignal_a <= #(ct_state2_b_a) 0;  // Clear error signal after critical timing expires
                           errorsignal_clk = 1;  // Critical timing on this input; assign immediately
                           errorsignal_clk <= #(ct_state2_b_clk) 0;  // Clear error signal after critical timing expires
                        end
                  endcase
               end
         end
   end

always @(posedge clk or negedge clk) // execute at positive and negative edges of input
   begin
      if ($time>4) // arbitrary steady-state time)
         begin
            if (errorsignal_clk == 1'b1)  // A critical timing is active for this input
               begin
                  outfile = $fopen("errors.txt", "a");
                  $fdisplay(outfile, "Violation of critical timing in module %m; %0d ps.\n", $stime);
                  $fclose(outfile);
                  out <= 1'bX;  // Set all outputs to unknown
               end
            if (errorsignal_clk == 0)
               begin
                  case (cell_state)
                     0: begin
                           errorsignal_a = 1;  // Critical timing on this input; assign immediately
                           errorsignal_a <= #(ct_state0_clk_a) 0;  // Clear error signal after critical timing expires
                           errorsignal_b = 1;  // Critical timing on this input; assign immediately
                           errorsignal_b <= #(ct_state0_clk_b) 0;  // Clear error signal after critical timing expires
                        end
                     1: begin
                           out <= #(delay_state1_clk_out) !out;
                           cell_state = 0;  // Blocking statement -- immediately
                           errorsignal_b = 1;  // Critical timing on this input; assign immediately
                           errorsignal_b <= #(ct_state1_clk_b) 0;  // Clear error signal after critical timing expires
                        end
                     2: begin
                           out <= #(delay_state2_clk_out) !out;
                           cell_state = 0;  // Blocking statement -- immediately
                           errorsignal_a = 1;  // Critical timing on this input; assign immediately
                           errorsignal_a <= #(ct_state2_clk_a) 0;  // Clear error signal after critical timing expires
                        end
                  endcase
               end
         end
   end

endmodule
