## wcm-components
This is a repository for storing WCM components and their versions.

The file structure should be as follows: Each component will have a seperate folder with each different version of the component will be stored as zip file inside the component's folder. An example of the file structure can be seen below 

**GitHub directory structure example:**
```
.
├── HAND                            # Component name
│   └── v1.zip
│
├── Economic                   
│   ├── v6.zip                      # zip file contains the component
│   ├── v5.zip               
│   └── unstable_version.zip        # Versions dont HAVE to be numbers
```

The zip file needs to contain everything a component has when downloaded from wings: The wings-component.yaml, src folder and data folder. The yaml should also be properly configured before it is uploaded onto GitHub. 

**File structure for zip example**:
```
└── Economic-v6                   
    ├── wings-component.yaml               
    ├── src   
    |    ├── run.sh
    |    └── crops.py 
    └── dat 
         └── data.csv
```

The `wings-component.yaml` is the YAML spec. declaring I/O. The "data" folder has `data` files to be used as input (optional). The `src` file contains the run file and the support scripts necessary to make the component work. A `Dockerfile` (optional) will include the description to build a docker image.

test
