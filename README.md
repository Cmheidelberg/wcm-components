# wcm-components
This is a repository for storing WCM components and their versions.

The structure should be as follows:
```yaml
- Component name, Example: economic
  - Component version number, Example: v6, v6.1
  - wings-component.yml
  - data
  - src
  - Dockerfile
```

The `wings-component.yml` is the YAML spec. declaring I/O. The "data" folder has `data` files to be used as input (optional). The `src` file contains the run file and the support scripts necessary to make the component work. A `Dockerfile` (optional) will include the description to build a docker image.
