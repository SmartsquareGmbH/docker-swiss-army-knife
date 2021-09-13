# Docker swiss army knife

A docker image for use in `kubectl run` commands for diagnostics.


## Installed tools

| Category | Title  | Binary name | What for? |
|----------|--------|-------------|-----------|
| scripting | [bash](https://tiswww.case.edu/php/chet/bash/bashtop.html) | `bash` | Shell scripting, interactive use |
| scripting | [python](https://www.python.org) | `python3` | |
| filesystem | ripgrep | `rg` | Alternative to grep, often faster |
| filesystem | fdfind | `fd` | Alternative to find, often faster |
| scripting | jq | `jq` | JSON processing/analysis |
| scripting | jc | `jc` | Convert standard command outputs (ifconfig, dig, etc.) to JSON for further processing |
| network:dns | [bind-tools](https://www.isc.org/) | `dig`, `nslookup` | DNS lookups |
| network:dns | dog | `dog` | DNS lookups |
| network:dns | dnstracer | `dnstracer` | DNS diagnostics |
| network:http | curl | `curl` | HTTP client |
| network:http | Apache AB | `ab` | Simple HTTP Load testing tool |
| network | ping | `ping` | Connectivity checking |
| network | traceroute | `traceroute`, `traceroute6` |Connectivity checking |
| network | paris-traceroute | `paris-traceroute` | Connectivity checking |
| network | tcpdump | `tcpdump` | Traffic analysis |
| network | BSD Netcat | `nc` | TCP/UDP client/server |
| network | socat | `socat` | TCP/UDP client/server - more complex to use than netcat, but more flexible |
| kubernetes | kubectl | `kubectl` | Kubernetes CLI |

## Usage examples


### Docker run

On linux, prefer to run the image in `network=host` mode. This is a requirement for `dnstracer` to work:  
`docker run -it --rm --name swiss-army-knife --network=host ghcr.io/smartsquaregmbh/swiss-army-knife:privileged`

On non-linux hosts, remove the `network=host` parameter, but leave everything else identical:  
`docker run -it --rm --name swiss-army-knife ghcr.io/smartsquaregmbh/swiss-army-knife:privileged`


### kubectl run

To start an interactive pod using the namespaces default service account, use the following:  
`kubectl run swiss-army-knife --attach --stdin --rm --tty --image=ghcr.io/smartsquaregmbh/swiss-army-knife:unprivileged`

In typical setups, this will _not_ allow you to use `kubectl` within the pod. You could add a suitable `--override` to run the pod with a more privileged account, but that quickly gets hard to read.  
If anything more than a basic shell, curl and dig is required, prefer `kubectl exec`ing into a pre-existing pod.

### Pod

Example manifests for pods are available in [examples/pod.yaml](examples/pod.yaml), [examples/pod-with-serviceaccount.yaml](examples/pod-with-serviceaccount.yaml) and [examples/pod-privileged.yaml](examples/pod-privileged.yaml).
