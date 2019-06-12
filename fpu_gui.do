package require Tk
project open ./fpuGUI; #project directory
wm title . "FPU"
grid [ttk::frame .c -padding "0 10 15 25"] -column 0 -row 0 -sticky nwes

grid [ttk::label .c.operandA -text "A:"] -column 2 -row 1 -sticky w -pady 10
grid [ttk::entry .c.operandAv -textvariable opa] -column 2 -row 2 -sticky w 
grid [ttk::label .c.operandB -text "B:"] -column 2 -row 3 -sticky w -pady 10
grid [ttk::entry .c.operandBv -textvariable opb] -column 2 -row 4 -sticky w 
grid [ttk::label .c.operationLabel -text "op"] -column 1 -row 2 -padx 25
grid [ttk::entry .c.operation -width 4 -textvariable "op"] -column 1 -row 3 -padx 25
grid [ttk::label .c.separator -text "___________________________"] -column 2 -row 5 -sticky w
grid [ttk::label .c.resultLabel -text "result"] -column 1 -row 6 -padx 25
grid [ttk::label .c.result -textvariable "result"] -column 2 -row 6 -sticky w
grid [ttk::button .c.calculate -text "=" -command calculate] -column 3 -row 7 -sticky we

project compileall

vsim work.fpu ;#design name (module name)
puts "----GUI was built sccessfully----"
proc calculate {} \
{
	set a_ "2#[exec ./fi.py $::opa]"
	set b_ "2#[exec ./fi.py $::opb]"

	force a $a_
	force b $b_
	if { [string equal $::op "*"] == 1 } {
		force funct "2#11"
		execute
	} elseif { [string equal $::op "+"] == 1 } {
		force funct "2#00"
		execute
	} elseif { [string equal $::op "-"] == 1 } {
		force funct "2#01"
		execute
	} elseif { [string equal $::op "/"] == 1 } {
		force funct"2#10"
		execute		
	} else {
		execute 0
	}
}
proc execute {{a 1}} \
{
	if { $a == 1 } {
		run 1000
		set res_ [examine -binary o]
		set ::result [exec ./bi.py $res_];
	} else {
		set ::result "use a valid symbol";		
	}

}