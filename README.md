# Application Request Profiling Tool

Application Request Profiler is a tool for benchmarking and profiling HTTP server endpoints (URLs).

It is based off [wrk2](https://github.com/giltene/wrk2) for running the benchmarks and 
the Application Profiler is a wrapper for better organisation of profiles and their results.

This tool is also using Docker for portability and ease of use without making changes 
to the existing infrastructure.

More information in [wiki](https://wiki.openbet.com/display/SBT/API+request+profiling).

## Setup

1. Clone the repository

```sh
$ git clone ssh://git@stash.int.openbet.com:7999/sbt/application-profiler.git application-profiler
```

2. Start the docker app

```sh
$ cd application-profiler
$ docker-compose up -d
```

# Configuration & Usage

The tool uses a "profile" for containing a batch of tests, these profiles are defined as YML files
and have the following structure. Predefined set of profiles can be found inside `src/profiles`.

```yml
--
name: sample-app-profiling
debug: 0
histogram: 1
base_url: http://sample-app
profiler:
  threads: 1
  connections: 10
  rate: 5
  duration: 5
calls:
  -
    name: no_delay
    active: 1
    auth: 0
    path: /delay/0/0
    script: /opt/profiler/src/profiles/lua/sample-app/get.lua
```

- `name` is the profile name, which is used as the output directory name which will contain results
of all tests (each item in `calls` is a test).
- `debug` on/off verbose output when the profiler is run.
- `histogram` on/off switch for producing a SVG graph of each call. This is useful for visualising histogram data
- `base_url` as field name suggests, this should contain the hostname of the HTTP service you are testing.
Later this hostname and path of each test is concatenated to produce the unique test URL.
which the tool outputs.
- `profiler` is an array. Contains parameters for running each test under `calls`.
  - `threads` number of threads to use for running a test.
  - `connections` number of connections to be used for running each test.
  - `rate` work rate (throughput) in requests/sec (total).
  - `duration` in seconds, how long to sustain each test.
- `calls` is an array. Your profile can have **one** or more tests. These are defined under this section and one should have
  following child fields filled.
  - `name` unique identifier for each endpoint which gets tested.
  - `active` you can on/off tests within a profle using this flag.
  - `auth` if authentication token should be used. Discussed further in the **auth** section of the document.
  - `path` the endpoint + parameters you want benchmarked. Ex: as per above `yml` file the `no_delay` test will use
    `http://sample-app/delay/0/0` as the test URL.
  - `script` a sample LUA script which can be used for manipulating request and response. Read more under "Scripting" section.


### Running a Profile
```sh
$ docker-compose exec wrk2 ./wrk2profiler <path-to-profile-yml>
```

For example, running a benchmark against the sample app can be done by running the command below.

```sh
docker-compose exec wrk2 ./wrk2profiler src/profiles/sample-app.yml
```

### Result
Each request tested will have its own result located in the `output` directory, with HdrHistogram inside if `histogram` flag was switched on.

The result directory will have the profile `name` + current system datetime combination for identification purposes.
Such as `sample-app-profiling_20180816_0531`