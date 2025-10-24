#
#   This sed file edits checks before they are added to allChecks.dat
#
#   remove the xml declaration
#
/<?xml version="1.0" encoding="UTF-8"?>/d
#
#   remove the mdq namespace prefix
#
/mdq:/s///
#
#   remove the mdq namespaces from the check element
#   this catches the namespace declarations that are on one line
#   with the check element like:
#   <mdq:check xmlns:mdq="https://nceas.ucsb.edu/mdqe/v1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="https://nceas.ucsb.edu/mdqe/v1 ../schemas/schema1.xsd">   
#
/<check.*>/s//<check>/
#
#   remove namespace declarations that are on separate lines like:
#   <mdq:check xmlns:mdq="https://nceas.ucsb.edu/mdqe/v1"
#   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
#   xsi:schemaLocation="https://nceas.ucsb.edu/mdqe/v1 ../schemas/schema1.xsd">
#
/ xmlns:mdq=\"https:\/\/nceas.ucsb.edu\/mdqe\/v1"/s///
/xmlns:xsi="http:\/\/www.w3.org\/2001\/XMLSchema-instance"/s///
/xsi:schemaLocation="https:\/\/nceas.ucsb.edu\/mdqe\/v1 ..\/schemas\/schema1.xsd">/s///
/<check$/s//<check>/


