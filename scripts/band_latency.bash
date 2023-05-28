#!/bin/bash

set -e

if [[ $# != 1 ]]; then
  echo "Error: name protocol"
  exit -1
fi

if [ ! -e ../data/${1}_throughput.dat ]; then
  echo "Error: unknown file"
  cd ../data && ls *_throughput.dat
  exit -1
fi

# samples
minSample=($(head -n 1 ../data/${1}_throughput.dat))
maxSample=($(tail -n 1 ../data/${1}_throughput.dat))

# min dim
minSampleDimBytes=$(sed -e 's/[eE]+*/\\*10\\^/' <<<${minSample[0]})   
# min throughput
minThroughput=$(sed -e 's/[eE]+*/\\*10\\^/' <<<${minSample[2]}) 			 

# max dim
maxSampleDimBytes=$(sed -e 's/[eE]+*/\\*10\\^/' <<<${maxSample[0]})    
# max throughput
maxThroughput=$(sed -e 's/[eE]+*/\\*10\\^/' <<<${maxSample[2]})  			 

# dim difference
dimDiff=$(echo ${maxSampleDimBytes}-${minSampleDimBytes} | bc -l)

# delays
DelayMin=$(echo ${minSampleDimBytes}/${minThroughput} | bc -l)
DelayMax=$(echo ${maxSampleDimBytes}/${maxThroughput} | bc -l)

# delay difference
delayDiff=$(echo ${DelayMax}-${DelayMin} | bc -l)

B=$(echo "scale=5; ${dimDiff}/${delayDiff}" | bc -l)
L=$(echo "scale=9; ((-${minSampleDimBytes})/${B}+${DelayMin})/1" | bc -l)

echo latenza: $L
echo banda: $B

# create folder if it doesn't exist
if [ ! -d ../data/${1}_data ]; then
  mkdir ../data/${1}_data
fi

# remove png
rm -f ../data/${1}_data/${1}.png

# generate png
gnuplot <<-eNDgNUPLOTcOMMAND
	f(x) = x / ( $L + x / $B)
	set term png size 900, 700
	set output "../data/${1}_data/${1}.png"
	set xrange [$minSampleDimBytes: ]
	set logscale x 2
	set logscale y 10
	set xlabel "msg size (B)"
	set ylabel "throughput (KB/s)"
	plot  f(x) title "Latency-Bandwith model with L = ${L} and B = ${B}" \
		with linespoints, \
		"../data/${1}_throughput.dat" using 1:3 title "${1} ping-pong Throughput" \
			with linespoints
	clear
eNDgNUPLOTcOMMAND

# open png
xdg-open ../data/${1}_data/${1}.png 2>>/dev/null &