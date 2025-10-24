#!/usr/local/bin/python3

import xml.etree.ElementTree as ET
import os
import re
import argparse

from shutil import copyfile

# Locate files starting at path, with filenames that match a regex
def findfiles(path, regex):
    #print("regex: {}".format(regex))
    regObj = re.compile(regex)
    res = []
    for root, dirs, fnames in os.walk(path):
        for fname in fnames:
            #print("fname: {}".format(fname))
            if regObj.match(fname):
                res.append(os.path.join(root, fname))
                #print("root: {}, fname: {}".format(root, fname))
    return res

if __name__ == '__main__':
    
    parser = argparse.ArgumentParser(description='stage MetaDIG checks and suites.')
    parser.add_argument('src', metavar='N', type=str, nargs='+',
                        help='source directory')
    parser.add_argument('dst', metavar='N', type=str, nargs='+',
                        help='destination directory')
    parser.add_argument('suites', metavar='N', type=str, nargs='+',
                        help='suites to stage')

    # args = parser.parse_args()
    src = "src" # args.src[0]
    dst = "dist" # args.dst[0]
    suites = "arctic-data-center-1.2.0.xml,ess-dive-1.3.0.xml,FAIR-suite-0.5.0.xml,knb-suite.xml,data-suite-0.1.0.xml".split(",")
    # args.suites[0].split(",")
    cwd = os.getcwd()
    
    print("source: {}".format(src))
    print("destination: {}".format(dst))
    print("suites: {}".format(suites))
    
    for suite in suites:
        # Parse the next suite XML to and find all the checks listed
        print("processing suite: {}".format(suite))
        copyfile("src/suites/{}".format(suite), "{}/suites/{}".format(dst, suite))

        tree = ET.parse('src/suites/{}'.format(suite))
        root = tree.getroot()

        # Loop through all '<check' elements in this suite XML file
        for check in root.findall('check'):
            # Get the <id> element from the check
            id = check.find('id').text
            print("id: {}".format(id))
            
        #print findfiles('src/checks', "<id>\s*{}\s*</id>".format(id))
        #print findfiles('./src/checks', "<id>\s*{}\s*</id>".format(id))
        
            # Find all check files available
            checkFiles = findfiles('{}/checks'.format(src), "^.*xml$")
            #print checkFiles
            # for this id, search each check file to find the check file with this id
            for file in checkFiles:
                tree = ET.parse(file)
                root = tree.getroot()
                id_elem = root.find(".//id")  # find the <id> element anywhere in the doc

                if id_elem is not None and id_elem.text == id:
                    print(f"found check id {id} in file {file}")
                    srcfile = os.path.join(cwd, file)
                    fname = os.path.basename(file)
                    dstfile = os.path.join(cwd, dst, "checks", fname)
                    print(f"cp {srcfile} {dstfile}")
                    copyfile(srcfile, dstfile)

