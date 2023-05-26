//20l-1283 q2

set ns [new Simulator]

# Create nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
set n7 [$ns node]

# Create links
$ns duplex-link $n0 $n1 512Kb 10ms DropTail
$ns duplex-link $n0 $n2 512Kb 10ms DropTail
$ns duplex-link $n0 $n3 512Kb 10ms DropTail
$ns duplex-link $n0 $n4 512Kb 10ms DropTail
$ns duplex-link $n0 $n5 512Kb 10ms DropTail
$ns duplex-link $n0 $n6 512Kb 10ms DropTail
$ns duplex-link $n0 $n7 512Kb 10ms DropTail

# Set queue size and scheduling algorithm
set queue [[$ns link $n0 $n5] queue]
$queue set limit_ 1000
$queue set queue_type SFQ

# Create agents
set tcp [new Agent/TCP]
set udp [new Agent/UDP]
set null [new Agent/Null]

# Attach agents to nodes
$ns attach-agent $n1 $tcp
$ns attach-agent $n2 $udp
$ns attach-agent $n4 $null

# Create a TCP sink agent at H4
set sink [new Agent/TCPSink]
$ns attach-agent $n5 $sink

# Connect agents to links
$ns connect $tcp $sink
$ns connect $udp $null

# Set up TCP data flow
$tcp set class_ 1
$tcp set packetSize_ 1000
$tcp set maxpkts_ 1000
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 0.1 "$ftp start"
$ns at 1.5 "$ftp stop"

# Set up UDP data flow
$udp set class_ 2
$udp set packetSize_ 1000
$udp set rate_ 256Kb
set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp
$ns at 0.2 "$cbr start"
$ns at 1.3 "$cbr stop"

# Bring link between SW1 and H5 down
$ns at 0.5 "$ns queue-limit $n0 $n5 0"
$ns at 0.9 "$ns queue-limit $n0 $n5 1000"

# Bring link between SW1 and H4 down
$ns at 0.7 "$ns queue-limit $n0 $n4 0"
$ns at 1.2 "$ns queue-limit $n0 $n4 1000"

# Stop simulation
$ns at 2.0 "$ns halt"

# Run simulation
$ns run


