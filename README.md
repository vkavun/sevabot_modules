Description
==========
These are [sevabot](http://sevabot-skype-bot.readthedocs.org) modules/commands, used for a day-to-day qa tasks.
Please install at first [sevabot](http://sevabot-skype-bot.readthedocs.org), and then add this repo files to your skype bot.

Every command has its own help, that a user can read a brief manual. For example:
```
!git help
```

Commands
==========

## git

This command turns on and off notifications from git, when something new was pushed.
Basically its valuable for those kind of projects, when git server has restricted access, due to security reasons
And a post-receive git hook cannot be set up.

This command creates a cronjob, that checks `git log` for any new arrivals, and fires them in Skype.
And its designed to manage each chat notifications separately (every chat can turn git notification on or off, independently)

Usage exmaple: 
```
!git start
!git stop
```

Notifications example
```
Something new was pushed to GIT!

John Galt -  (HEAD, origin/master, master) - Initial commit
```

## jira

This command turns on and off notifications from JIRA, with new tickets that were created.
It also creates a cronjob, that ping jira api for any new tickets.

Search filter can be modified in `settings.py` as *JIRA_QUERY*
Jira login and pass are also stored there.
And similar to `git` command, each chat can turn on or off jira notifications

Usage exmaple: 
```
!jira start
!jira stop
```

Notification example:
```
New tickets were created!

John Galt - https://jira.server.com/jira/browse/JIRA-123
```

## version

This command returns version of application deployed to specific qa servers.
Qa server addresses are stored in `settings.py` in *QA_SERVERS* array.
Also qa server url, that shows application version, can be modified there as *VERSION_APPENDIX* 

Usage exmaple:
```
!version qa.server1.com
!version qa.server2.com
```
In this case `!version` - all qa machine versions will be returned

Response example:
```
qa.server1.com  -  1.3.2.s2-SNAPSHOT
qa.server2.com  -  1.2.s2.6-SNAPSHOT
```

## who

This command returns user who's logged in specific qa server.
Also it returns date+time of a last POST or GET request to this server (helps to understand if someone uses it right now)
Please list all QA servers in `settings.py` file. That sevabot can check correctness of qa server url, passed to this command

Usage exmaple: 
```
!who qa.server.com
```

Response example:
```
qa.server.com  -  ec2-user, root, guest
```

## tomcat

This command restarts tomcat on indicated QA server.
And when its done, sends notification back to the chat, that tomcat has successfully been restarted.
Scripts also checks that nobody is already restarting tomcat on a server, that no conflicts occur

Notifications look like:

```
Tomcat has started on qa.server.com!
```

Usage example:
```
!tomcat qa.server.com
```

