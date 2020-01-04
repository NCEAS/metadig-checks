#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Dec 19 13:22:23 2019

@author: tedhabermann
"""
#
# Create a list of check names from the name hierarchy
# consist only of lower/upper case letters and periods (.)
#
import re
import requests

def findUseCase(labels):
    FAIR = ['Findable','Accessible','Interoperable','Reusable']
    for useCase in FAIR:
        if useCase in labels:
            return useCase
    return 'None'


def findLevel(labels):
    levels = ['Essential','Supporting']
    for level in levels:
        if level in labels:
            return level
    return 'None'


owner = 'NCEAS'
repository = 'metadig-checks'
maxIssuePage = 12
checkNames = []

for page in range(1, maxIssuePage):
    url = 'https://api.github.com/repos/' + owner + '/' + repository
    url += '/issues?page=' + str(page)
    r = requests.get(url)
    #
    # loop through the issues for each page
    #
    for issue in r.json():
        #
        # select issues where names contain just upper or lower case
        # letters and "."
        # Create list of tokens: ['issueNumber','title','milestone',
        # labels (comma separated, name tokens (tab separated))]
        #
        if re.match('^[A-Za-z\.]*$', issue['title']):
            tokenList = [str(issue['number'])]
            tokenList.append(issue['title'])
            
            if issue['milestone'] is not None:
               if issue['milestone']['title'] is not None:
                    tokenList.append(issue['milestone']['title'])
            else:
                tokenList.append('')

            labelList = list([label['name'] for label in issue['labels'] if 'name' in label])
            tokenList.append(labelList)
            #
            # add issue to big list
            #
            checkNames.append(tokenList)

with open('metaDIGIssueData.txt', 'w') as output:
    print('ID\tTitle\tMilestone\tLabels\tUseCase\tLevel\tt1\tt2\tt3\tt4\tt5\tt6\tt7', file=output)
    
    for check in checkNames:
        #
        # fill empty name tokens for better pivot table display (no (blank))
        #
        nameTokens = check[1].replace(".", '\t')
        tokenCount = len(nameTokens.split('\t'))
        while tokenCount < 7:
            nameTokens += '\t '
            tokenCount += 1
                    
        print("%s\t%s\t%s\t%s\t%s\t%s\t%s" %
              (check[0], check[1], check[2],
               ','.join(check[3]), findUseCase(check[3]),
               findLevel(check[3]), nameTokens), file=output)

print('metaDIGIssueData.txt created')
