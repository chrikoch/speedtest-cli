maxY=50

set terminal png
set output 'speedtest.png'
set xdata time
set timefmt '%d.%m.%Y %H:%M'
set datafile separator ";"
set yrange [0:maxY]
set xtics rotate

plot 'speedtest.csv' using 1:($2/(1024*1024)) title "Down (Mbps)", 'speedtest.csv' using 1:($3/(1024*1024)) title "Up (Mbps)"

