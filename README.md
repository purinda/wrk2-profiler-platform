h1. Application Request Profiling Tool

This tool uses [wrk2|https://github.com/giltene/wrk2] to perform load test on API requests.

# Setup

{code:shell}
stack -p sportsbet up app_profiler
{code}

# Test
Connect to the docker container first, then run

{code:shell}
application-profiler/run_test
{code}

# Result
Each request tested will have its own result located in /tmp/request_lt_result_201XXXXX_XXXX folder. There is also an [HdrHistogram|http://hdrhistogram.org/] inside the folder.