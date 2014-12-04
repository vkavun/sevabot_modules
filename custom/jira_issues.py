uthor__ = 'vova'

from jira.client import JIRA

import os
import sys
sys.path.append(os.path.join(os.path.dirname(os.path.abspath(__file__)), ".."))

import settings

options = {
    'server': settings.JIRA_SERVER
}

jira = JIRA(options=options, basic_auth=(settings.JIRA_LOGIN, settings.JIRA_PASS))

issues = jira.search_issues(settings.JIRA_QUERY)

# print issues

for s in issues:
    print s.fields.reporter.displayName + " - " + settings.JIRA_SERVER + "/browse/" + s.key + "  - " + s.fields.summary
