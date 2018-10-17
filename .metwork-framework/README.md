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
