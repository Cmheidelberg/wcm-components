# wcm-components
This is a repository for storing WCM components and their versions.

The structure should be as follows:

-Domain
 |-Component name
  |-Component version number
   |-wings-component.yml
   |-data
   |-src
   |-Dockerfile

The wings-component.yml is the YAML spec declaring I/O. The "data" folder has data files to be used as input (optionaL). The src file contains the run file and the support scripts necessary to make the component work. A Dockerfile (optional) will include the description to build a docker image.
