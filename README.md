# wcm-components
This is a repository for storing WCM components and their versions.

The file structure should be a folder for each component with the zipped versions of each component inside

Example:
```
.
├── HAND                     # Component name
│   └── v1.zip
│
├── Economic                   
│   ├── v6.zip               # zip file contains zipped component
│   ├── v5.zip               
│   └── unstable_version.zip         # Versions dont HAVE to be numbers
```

The zip file needs to contain everything a component has when downloaded from wings: The wings-component.yaml, src folder and data folder. The yaml should also be properly configured before it is uploaded onto GitHub. 

Example of file structure for zip:
```
└── Economic                   
    ├── wings-component.yaml               
    ├── src   
    |    ├── run.sh
    |    └── crops.py 
    └── dat 
         └── data.csv
```

The `wings-component.yaml` is the YAML spec. declaring I/O. The "data" folder has `data` files to be used as input (optional). The `src` file contains the run file and the support scripts necessary to make the component work. A `Dockerfile` (optional) will include the description to build a docker image.
