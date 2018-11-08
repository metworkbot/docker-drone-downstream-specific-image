# docker-drone-downstream-specific-image

[//]: # (automatically generated from https://github.com/metwork-framework/resources/blob/master/cookiecutter/%7B%7Bcookiecutter.repo%7D%7D/README.md)

## Status (master branch)
[![Drone CI](http://metwork-framework.org:8000/api/badges/metwork-framework/docker-drone-downstream-specific-image/status.svg)](http://metwork-framework.org:8000/metwork-framework/docker-drone-downstream-specific-image)
[![DockerHub](https://github.com/metwork-framework/resources/blob/master/badges/dockerhub_link.svg)](https://hub.docker.com/r/metwork/docker-drone-downstream-specific-image/)
[![Maintenance](https://github.com/metwork-framework/resources/blob/master/badges/maintained.svg)]()

## What is it ?

This is a custom drone "downstream" plugin for our use case and our CI hardware.

The idea is to get a conditional "downstream" plugin. If there is a `.drone_downstream_bypass`
file in the working directory, the step is bypassed.

## Configuration example

```
pipeline:
  step:
    image: metwork/drone-downstream-specific-image:latest
    pull: true
    secrets: [ drone_server, drone_token ]
    repositories:
      - metwork-framework/mfserv
      - metwork-framework/mfbase@integration
    params:
      - foo1=bar1
      - foo2=bar2
    when:
      branch: master
      event: push
      status: success
```




## Contributing guide

See [CONTRIBUTING.md](CONTRIBUTING.md) file.



## Code of Conduct

See [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) file.


