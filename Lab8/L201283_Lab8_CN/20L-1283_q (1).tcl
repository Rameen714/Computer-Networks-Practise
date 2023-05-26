set ns [new Simulator]
# open namfile
set nf [open out.nam w]
$ns namtrace-all $nf

# define a finish procedure
proc finish {} {
global ns nf
$ns flush-trace
close $nf
exec nam out.nam
exit 0
}
# creating nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

#creating the links
$ns duplex-link $n0 $n2 2Mb 10ms DropTail 
$ns duplex-link $n1 $n2 2Mb 10ms DropTail 
$ns duplex-link $n2 $n3 1.7Mb 20ms DropTail 

# setting queue limit 
$ns queue-limit $n2 $n3 10

#setting orientation
$ns duplex-link-op $n0 $n2 orient right-down
$ns duplex-link-op $n1 $n2 orient left
$ns duplex-link-op $n1 $n2 orient right-up
$ns duplex-link-op $n2 $n3 orient right

$ns color 1 red
$ns color 2 blue

#setting the agents
set udp [new Agent/UDP]
$udp set fid_ 1
set null [new Agent/Null]
$ns attach-agent $n0 $udp
$ns attach-agent $n3 $null
$ns connect $udp $null

set tcp [new Agent/TCP]
$tcp set fid_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $n1 $tcp
$ns attach-agent $n3 $sink
$ns connect $tcp $sink

#setting app layer protocols
set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp
$cbr set packet_size_ 1000
$cbr set rate_ 1Mb

set ftp [new Application/FTP]
$ftp attach-agent $tcp


$ns at 0.1 "$cbr start"
$ns at 4.5 "$cbr stop"

$ns at 0.5 "$ftp start"
$ns at 4.0 "$ftp stop"

$ns at 5 "finish"
$ns run
