Bro scripts for miminal analysis and logging to save compute cycles:

1. disable-analyzer-log.bro: disables most of the analyzers and loggers for less compute intensive operation by Bro.
Save this file in the path: /usr/local/bro/share/bro/policy/misc/ or $PREFIX/share/bro/policy/misc/

2. Also modify the local.bro file in "/usr/local/bro/share/bro/site/" to add the new module as
@load misc/disable-analyzer-log.bro
