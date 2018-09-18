onerror {quit -f}
vlib work
vlog -work work trabalho_dia_120918.vo
vlog -work work trabalho_dia_120918.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.maq_primos_vlg_vec_tst
vcd file -direction trabalho_dia_120918.msim.vcd
vcd add -internal maq_primos_vlg_vec_tst/*
vcd add -internal maq_primos_vlg_vec_tst/i1/*
add wave /*
run -all
