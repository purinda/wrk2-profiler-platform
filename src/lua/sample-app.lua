-- HTTP method, body, and adding a header

wrk.method = "POST"
wrk.body   = ""
wrk.headers["Content-Type"] = "application/json"