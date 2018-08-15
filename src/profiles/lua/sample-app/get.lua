-- HTTP method, body, and adding a header
-- done() function that prints latency percentiles as CSV

wrk.method = "GET"
wrk.headers["Content-Type"] = "application/json"

done = function(summary, latency, requests)
    io.write("------------------------------\n")
    for _, p in pairs({ 50, 90, 99, 99.999 }) do
       n = latency:percentile(p)
       io.write(string.format("%g%%,%d\n", p, n))
    end
 end