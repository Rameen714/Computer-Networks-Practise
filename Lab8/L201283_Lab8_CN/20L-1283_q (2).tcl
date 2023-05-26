puts "Enter a number greater than 4"
set x [gets stdin]
puts ""
if {$x % 2 == 0} {
    for {set y 4} {$y <= $x} {set y [expr $y+2] } {
    puts $y
}
} else {
    for {set y 3} {$y <= $x} {set y [expr $y+2] } {
    puts $y
    }
}