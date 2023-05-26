//20l-1283 Q1

set ns [new Simulator]

# Create nodes
for {set i 0} {$i < 7} {incr i} {
    set node($i) [$ns node]
}

# Create links
for {set i 0} {$i < 6} {incr i} {
    set j [expr {$i+1}]
    $ns duplex-link $node($i) $node($j) 512Kbps 5ms DropTail
}
$ns duplex-link $node(6) $node(0) 512Kbps 5ms DropTail

# Set routing protocol to DV
$ns rtproto DV

# Send UDP packets from node 0 to node 3
set udp0 [new Agent/UDP]
$ns attach-agent $node(0) $udp0
set null0 [new Agent/Null]
$ns attach-agent $node(3) $null0
$ns connect $udp0 $null0
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 1000
$cbr0 set interval_ 0.01
$cbr0 set rate_ 100
$cbr0 attach-agent $udp0
$ns at 0.02 "$cbr0 start"
$ns at 1.5 "$cbr0 stop"

# End the simulation
$ns at 2.0 "finish"
$ns run

# Monitor the queue between node 0 and node 1
set q01 [$ns monitor-queue $n0 $n1]
$ns at 0.0 "$q01 start 0.1"
$ns at 2.0 "$q01 stop"

# Monitor the queue between node 0 and node 6
set q06 [$ns monitor-queue $n0 $n6]
$ns at 0.0 "$q06 start 0.1"
$ns at 2.0 "$q06 stop"
