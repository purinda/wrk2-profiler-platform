-- HTTP method, body, and adding a header

wrk.method = "POST"
wrk.body   = "classIds=1"
wrk.headers["Content-Type"] = "application/x-www-form-urlencoded"