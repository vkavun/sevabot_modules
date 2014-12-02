#: Known shared secret key in order to send messages over HTTP interface
SHARED_SECRET = "secret"

#: List of Skype usernames who can administrate the bot
ADMINS = ["vkavun"]

#: List of paths where we scan command-line modules
#: Can be absolute path or relative to the current working directory
MODULE_PATHS = ["modules"]

#: How fast module script must finish
TIMEOUT = 30

#: Where we run our HTTP interface
HTTP_HOST = "my.sevabot.host"

#: Which port we run our HTTP interface
HTTP_PORT = 5001

#: Set logging level (INFO or DEBUG)
#: This setting overrides --verbose option
#: LOG_LEVEL = "INFO"

#: Setup Python logging for Sevabot
#: Absolute path or relative to the settings file location
LOG_FILE = "logs/sevabot.log"

# http://docs.python.org/library/logging.html
LOG_FORMAT = "%(asctime)s - %(name)s - %(levelname)s - %(message)s"

#: Log rotation options
LOG_ROTATE_COUNT = 10

LOG_ROTATE_MAX_SIZE = 1024 * 1024

#: Log all HTTP requests for debugging purposes
DEBUG_HTTP = False

SEVABOT_HOME = "/sevabot/home"

# QA SERVERS SETTINGS
QA_SERVERS=[ "qa.server1.com", "qa.server2.com"]
VERSION_APPENDIX = "/path/to/endpoint/on/servers"

# GIT SETTINGS
GIT_REPO = "/git/repo"

# JIRA SETTINGS
JIRA_SERVER="https://jira.server.com/jira"
JIRA_LOGIN="login"
JIRA_PASS="pass"
JIRA_QUERY="query to get jira issues" # project in (project_name) and reporter in (user1, user2) and created >= -5m
