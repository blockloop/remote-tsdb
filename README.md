# Remote TSDB

```
Usage of remote-tsdb:
  -data-dir string
        filesystem path to store tsdb data (default "./data")
  -listen-addr string
        web address to listen for RemoteRead and RemoteWrite (default ":8080")
  -log-level string
        log level info or error (default "info")
  -no-lockfile
        disable the use of the TSDB lockfile
  -retention-duration duration
        tsdb retention time (default 48h0m0s)
  -wal-segment-size string
        Write Ahead Log segment size (default "10MB")
```

Remote TSDB is [TSDB](https://github.com/prometheus/tsdb) wrapped with HTTP
endpoints for RemoteRead and RemoteWrite. You can run `remote-tsdb` on a
persistent disk and run an ephemeral instance of Prometheus (i.e. in
Kubernetes), configured to remote-read and remote-write against
`remote-tsdb`. You can also write against the running `remote-tsdb` whild
Prometheus is running.

See [the Prometheus docs](https://prometheus.io/docs/prometheus/latest/storage/#remote-storage-integrations) for more details