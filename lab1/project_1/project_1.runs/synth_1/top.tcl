# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
debug::add_scope template.lib 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a100tcsg324-3

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir /afs/ece.cmu.edu/usr/xli2/Private/18545/18545-project/lab1/project_1/project_1.cache/wt [current_project]
set_property parent.project_path /afs/ece.cmu.edu/usr/xli2/Private/18545/18545-project/lab1/project_1/project_1.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
read_verilog -library xil_defaultlib -sv {
  /afs/ece.cmu.edu/usr/xli2/Private/18545/18545-project/lab1/sum_fsm.sv
  /afs/ece.cmu.edu/usr/xli2/Private/18545/18545-project/lab1/BCDtoSevenSegment.sv
  /afs/ece.cmu.edu/usr/xli2/Private/18545/18545-project/lab1/top.sv
}
read_xdc /afs/ece.cmu.edu/usr/xli2/Private/18545/Nexys4_Master.xdc
set_property used_in_implementation false [get_files /afs/ece.cmu.edu/usr/xli2/Private/18545/Nexys4_Master.xdc]

synth_design -top top -part xc7a100tcsg324-3
write_checkpoint -noxdef top.dcp
catch { report_utilization -file top_utilization_synth.rpt -pb top_utilization_synth.pb }
