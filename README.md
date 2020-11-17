# CellarTracker x Alfred

This will fetch your wine cellar contents from cellartracker.com, convert it to JSON and display it in an Alfred List.

### Requirements
- [jq](https://linux.die.net/man/1/iconv)
- [csvtojson](https://www.npmjs.com/package/csvtojson)
- iconv


To get this into alfred:

1. Create new "Script Filter" workflow
2. Doubleclick "jsonformat"
3. set "Script file" to External Script -> cellarTrackerToJSON:.sh 
4. Set Workflow Environment Variables with the icon that looks like `[x]`
    - `CELLAR_TRACKER_PASSWORD`
    - `CELLAR_TRACKER_UNAME`
    - `PATH` -> `/user/local/bin:/user/bin/:$PATH`
