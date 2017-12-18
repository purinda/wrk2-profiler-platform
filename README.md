# Application Request Profiling Tool

This tool can perform load test on API requests in local environment. It creates a docker container and uses [wrk2](https://github.com/giltene/wrk2) for the load test. Each request will have its own result. There will also be an [HdrHistogram](http://hdrhistogram.org/) based on statistics from all requests.

## Setup
#### 1. Check out scripts
```sh
$ git clone ssh://git@stash.int.openbet.com:7999/sbt/application-profiler.git application-profiler
```

#### 2. Add a link in ~/git_src/releases
```sh
$ ln -s application-profiler ~/git_src/releases/application-profiler
```

#### 3. Start testing docker container

```sh
$ stack -p sportsbet up app_profiler
```

## Test
Connect to the docker container first:
```sh
$ stack -p sportsbet conn app_profiler
```

then run

```sh
$ application-profiler/run_test
```

## Result
Each request tested will have its own result located in /tmp/request_lt_result_201XXXXX_XXXX/ folder, with HdrHistogram inside as well.

## Configuration
#### 1. General
General setting for the test stored in application-profiler/config

| Name | Sample Value | Description |
| ------ | ------ | ------ |
| CONNECTIONS | 10 | Connections to keep open |
| DURATION | 30s | Duration of test, may include a time unit (2s, 2m, 2h) |
| THREADS | 2 | Number of threads to use |
| RATE | 100 | Work rate (throughput) in requests/sec (total) |

#### 2. Request specific
Requests for the same application stored in a single file in application-profiler/profiles/, e.g. obmw-requests.dat
For post request, there will be a lua script setting parameters for each request. The file locates in application-profiler/lua/

```sh
1	0	/sportsbook/competitions	competitions.lua	competitions
1	1	/history/bets	default.lua	history-bets
```

#### Field explaination
| No. | Description | Value |
| ------ | ------ | ------ |
| 1 | Test switch for on or off | 0/1 |
| 2 | Is authentication token required | 0/1 |
| 3 | Request path | string |
| 4 | Lua file name for post request | file name |
| 5 | Output file name | string |

#### Post request setting
```lua
wrk.method = "POST"
wrk.body   = "classIds=1&numMarkets=5"
wrk.headers["Content-Type"] = "application/x-www-form-urlencoded"
```
