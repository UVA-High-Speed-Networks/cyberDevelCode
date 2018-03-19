Bro scripts for miminal analysis and logging to save compute cycles:

1. disable-analyzer-log.bro: disables most of the analyzers and loggers for less compute intensive operation by Bro.
Save this file in the path: /usr/local/bro/share/bro/policy/misc/ or $PREFIX/share/bro/policy/misc/

2. Also modify the local.bro file in "/usr/local/bro/share/bro/site/" to add the new module as
@load misc/disable-analyzer-log.bro


Difference of logging:
minimal logging:
sourav@sourav-VirtualBox:/usr/local/bro/logs/2018-03-19$ ls -alh
total 52K
drwxr-xr-x 2 root root 4.0K Mar 19 17:24 .
drwxr-xr-x 4 root root 4.0K Mar 19 17:19 ..
-rw-r--r-- 1 root root 3.9K Mar 19 17:23 conn.17:19:27-17:23:31.log.gz
-rw-r--r-- 1 root root  630 Mar 19 17:23 conn.17:23:31-17:23:32.log.gz
-rw-r--r-- 1 root root  848 Mar 19 17:23 conn-summary.17:19:27-17:23:31.log.gz
-rw-r--r-- 1 root root  574 Mar 19 17:23 conn-summary.17:23:31-17:23:32.log.gz
-rw-r--r-- 1 root root 4.6K Mar 19 17:23 dns.17:19:27-17:23:31.log.gz
-rw-r--r-- 1 root root  962 Mar 19 17:23 http.17:19:37-17:23:31.log.gz
-rw-r--r-- 1 root root 1.8K Mar 19 17:23 ssl.17:19:45-17:23:31.log.gz
-rw-r--r-- 1 root root  440 Mar 19 17:23 ssl.17:23:31-17:23:32.log.gz
-rw-r--r-- 1 root root  142 Mar 19 17:23 stderr.17:19:02-17:23:32.log.gz
-rw-r--r-- 1 root root  108 Mar 19 17:23 stdout.17:19:02-17:23:32.log.gz

as compared to all logging:
sourav@sourav-VirtualBox:/usr/local/bro/logs/prev-logs$ ls -alh
total 100K
drwxr-xr-x 2 root root 4.0K Mar 19 16:50 .
drwxr-xr-x 4 root root 4.0K Mar 19 17:19 ..
-rw-r--r-- 1 root root  212 Mar 19 16:49 capture_loss.16:43:02-16:49:22.log.gz
-rw-r--r-- 1 root root 1.1K Mar 19 16:49 communication.16:43:04-16:49:18.log.gz
-rw-r--r-- 1 root root  356 Mar 19 16:49 communication.16:49:19-16:49:22.log.gz
-rw-r--r-- 1 root root 5.8K Mar 19 16:49 conn.16:43:46-16:49:18.log.gz
-rw-r--r-- 1 root root  739 Mar 19 16:49 conn.16:49:19-16:49:22.log.gz
-rw-r--r-- 1 root root  799 Mar 19 16:49 conn-summary.16:43:46-16:49:18.log.gz
-rw-r--r-- 1 root root  608 Mar 19 16:49 conn-summary.16:49:19-16:49:22.log.gz
-rw-r--r-- 1 root root 5.4K Mar 19 16:49 dns.16:43:46-16:49:18.log.gz
-rw-r--r-- 1 root root 5.1K Mar 19 16:49 files.16:44:06-16:49:18.log.gz
-rw-r--r-- 1 root root 1.2K Mar 19 16:49 http.16:44:06-16:49:18.log.gz
-rw-r--r-- 1 root root 2.7K Mar 19 16:49 loaded_scripts.16:43:04-16:49:18.log.gz
-rw-r--r-- 1 root root  194 Mar 19 16:49 packet_filter.16:43:04-16:49:18.log.gz
-rw-r--r-- 1 root root  512 Mar 19 16:49 reporter.16:43:14-16:49:18.log.gz
-rw-r--r-- 1 root root 2.2K Mar 19 16:49 ssl.16:44:22-16:49:18.log.gz
-rw-r--r-- 1 root root  422 Mar 19 16:49 ssl.16:49:19-16:49:22.log.gz
-rw-r--r-- 1 root root  374 Mar 19 16:49 stats.16:43:04-16:49:18.log.gz
-rw-r--r-- 1 root root  143 Mar 19 16:49 stderr.16:43:02-16:49:22.log.gz
-rw-r--r-- 1 root root  108 Mar 19 16:49 stdout.16:43:02-16:49:22.log.gz
-rw-r--r-- 1 root root 2.9K Mar 19 16:49 weird.16:43:04-16:49:18.log.gz
-rw-r--r-- 1 root root 2.7K Mar 19 16:49 x509.16:44:17-16:49:18.log.gz
