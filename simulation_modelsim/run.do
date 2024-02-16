#
# helper functions
#


# neues Spiel, neues Glueck
proc nsng {} {

    restart -f
#    echo "Disable Warnings"
    set StdArithNoWarnings 1
    set NumericStdNoWarnings  1
    run 0 ps

#    when -label enable_StdWarn {system_i0/q(99) != '0'} {echo "Enable Warnings" ; set StdArithNoWarnings 0 ; set NumericStdNoWarnings 0 ;}
    set StdArithNoWarnings 0
    set NumericStdNoWarnings  0

    run -all
}


proc r {} {
    nsng
}


# restart with clear
proc rc {} {
    .main clear
    r
}                                                                                                                                  
                                                                                                                                   
                                                                                                                                   
                                                                                                                                   
proc my_debug {} {                                                                                                                 
    global env                                                                                                                     
    foreach key [array names env] {                                                                                                
        puts "$key=$env($key)"                                                                                                     
    }                                                                                                                              
}                                                                                                                                  
                                                                                                                                   
                                                                                                                                   
proc x {} {                                                                                                                        
    exit -force                                                                                                                    
}                                                                                                                                  
                                                                                                                                   
# get env variables
global env
quietly set top $env(top)


if {[file exists wave_$top.do]} {
    puts "INFO: load wave_$top.do"
    do wave_$top.do
} else {
    puts "WARNING: no wave_$top.do found."
    if {[file exists wave.do]} {
        puts "INFO: load wave.do"
        do wave.do
    } else {
        puts "WARNING: no wave.do found."
    }
}


r
                                                                                                                        
