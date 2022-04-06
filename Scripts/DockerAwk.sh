NF == 1 {
   ram[$1] = cpu[$1] = network[$1] = io[$1] = 0 ;
}
NF > 1 {
   for (r in ram ) 
       if (substr($2,1,length(r)) == r ) {
          ram[r]+=$3 ; cpu[r]+=$4 ; network[r] += $8 ; io[r] += $11 ;
   }
}
END { for (r in ram )
       printf "%-25s %6.2f %6d %6d %6d\n",r,ram[r],cpu[r],network[r],io[r] ; 
    }