#!/bin/sh
#
# Program: Print GC times <gctime>
#
# Author: Matty < matty91 at gmail dot com >
#
# Current Version: 1.0
#
# Revision History:
#
#  Version 1.0
#    Initial Release
#
# Last Updated: 02-16-2008
#
# Purpose:
#   This script analyzes GC logs to see how much time is spent
#   performing garbage collection.
#
# Notes:
#   This script requires that the JVM was started with the "-XX:+PrintGCApplicationStoppedTime"
#   and "-XX:+PrintGCApplicationConcurrentTime" options.
#
# License:
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
# Example:
#   $ gctime gc.log
#   Total execution time               : 66.30secs
#   Time application ran               : 55.47secs
#   Time application was stopped       : 10.84secs
#   % of time application ran          : 83.65%
#   % of time application was stopped  : 16.35%

if [ ! -f "${1}" ]
then
    echo "Usage: $0 <GC Log>"
    exit 1
fi

awk '/Application time/     { apprun += $(NF-1) } 
     /threads were stopped/ { appstop +=  $(NF-1) } 
     END { 
          total = apprun + appstop
          printf("Total execution time               : %.2fsecs\n", total)
          printf("Time appication ran                : %.2fsecs\n", apprun)
          printf("Time application was stopped       : %0.2fsecs\n", appstop) 
          printf("%% of time application ran          : %.2f%%\n", apprun / total * 100)
          printf("%% of time application was stopped  : %.2f%%\n", appstop / total * 100) 
     }' ${1}
grep "Total time for which application threads were stopped" ${1} |awk 'BEGIN{max=0;total=0;count=0;longstopcount=0;}{if(max<$9){max=$9} if($9>0.5){longstopcount=longstopcount+1;} total=total+$9;count=count+1}END{print "max:"max;print ">500ms "longstopcount;print "avg:"total/count;}'
