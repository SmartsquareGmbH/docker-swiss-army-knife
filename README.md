# Docker swiss army knife

A (somewhat) small docker image for use in `kubectl run` commands for diagnostics.

Contains the following useful tools, in no particular order:

* `bash`
* Apache `ab` - Simple HTTP Load testing tool
* `ping`
* `dig`, `nslookup`, `dog` and `dnstracer` - DNS lookup and diagnostics
* `traceroute`, `traceroute6` and `paris-traceroute`
* `tcpdump`
* `curl`
* `jq`
* `kubectl`
* `nc` and `socat`