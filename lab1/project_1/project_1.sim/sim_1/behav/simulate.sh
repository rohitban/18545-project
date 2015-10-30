#!/bin/sh -f
xv_path="/afs/ece/support/xilinx/xilinx.release/Vivado"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep $xv_path/bin/xsim sum_test_behav -key {Behavioral:sim_1:Functional:sum_test} -tclbatch sum_test.tcl -log simulate.log
