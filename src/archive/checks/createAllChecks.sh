#!/bin/bash
#
#   This script creates aggregates all of the individual checks into a
#   single file called allChecks.xml. 
#
#   This file has a root element allChecks that wraps all of the checks.
#
#   Run this script as creatreAllChecks.sh in the checks directory
#
rm allChecks.xml
#
#   Count xml files
#
FILECOUNT=$(ls -1 *.xml | wc -l)
echo $FILECOUNT XML files 
#
#   Add XML header
#
echo '<?xml version="1.0" encoding="UTF-8"?>' > allChecks.dat
echo '<mdq:allChecks xmlns:mdq="https://nceas.ucsb.edu/mdqe/v1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="https://nceas.ucsb.edu/mdqe/v1 ../schemas/schema1.xsd">' >> allChecks.dat
#
#   copy xml files
#
for i in *.xml; do sed -f cleanChecks.sed "$i" >> allChecks.dat; done
#
#   Add closing element
#
echo '</mdq:allChecks>' >> allChecks.dat
#
#   rename allChecks.dat and count checks in allChecks.xml
#
mv allChecks.dat allChecks.xml
#
CHECKCOUNT=$(grep '<check>' allChecks.xml | wc -l)
echo $CHECKCOUNT checks in allChecks.xml
