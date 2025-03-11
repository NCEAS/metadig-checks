## metadig-checks: MetaDIG suites and checks for data and metadata improvement and guidance.


- **Author**: Matthew B. Jones, Peter Slaughter ([NCEAS](http://www.nceas.ucsb.edu)), Ted Habermann, Sean Gordon
- **License**: [Apache 2](http://opensource.org/licenses/Apache-2.0)
- [**Submit Bugs and feature requests**](https://github.com/NCEAS/metadig-checks/issues)

`metadig-checks` contain metadata quality checks that are used by the [MetaDIG Quality engine](https://github.com/NCEAS/metadig-engine).

A glossary of metadata terms is available on the ESIP Wiki at http://wiki.esipfed.org/index.php/Concepts_Glossary. This glossary is open for editing / additions to the whole ESIP community.

## MetaDIG Data Suite Checks

In `metadig-checks`, data suite quality checks are written in Python.
Below is a template from which to begin writing data checks from:

```py
def call():
    global output
    global status
    global output_identifiers
    global output_type
    global metadigpy_result

    # Import your required libariries to perform the data check you're writing
    from metadig import StoreManager
    import metadig as md
    import pandas as pd
    ...

    # Get a manager object so that we can retrieve objects
    manager = StoreManager(storeConfiguration)  

    # The variables below are used by the Metadig-Engine, MetacatUI and other clients
    output_identifiers = [] # This is a lit of pids that have been checked
    output_data = [] # This array contains the corresponding message for the list of pids checked
    status_data = [] # This array represents the results for each pid checked: 'SUCCESS' or 'FAILURE'
    output_type = [] # This is the type of data found in 'output_data': 'text' or 'markdown'
    metadigpy_result = {} # This dictionary is required for 'MetaDIG-py' to return check results

    # Set appropriate output if dataPids are unavailable
    if len(dataPids) == 0:
        output_data = "No data objects found."

    # Confirm datapids are present and loop over them
    for pid in dataPids:
        # Retrieve data object and sysmeta
        output_identifiers.append(pid)

        # Retrieve and validate the object
        try:
            obj, sys = manager.get_object(pid)
            # Perform desired action on 'obj' retrieved
            # TODO: Perform desired check actions
            # Add the results for the pid processed 
            # If the retrieved object is not valid and should not be checked
            # you may want to skip it. For example:
            # obj, fname, status = md.get_valid_csv(manager, pid)
            # if status == "SKIP":
            #     output_data.append(f"Placeholder Text For Invalid Data Object")
            #     output_type.append("text")
            #     status_data.append(status)
            continue
        except Exception as e:
            # Record an unexpected issue and move onto checking the next pid
            output_data.append(f"Unexpected Exception: {e}")
            output_type.append("text")
            status_data.append("FAILURE")
            continue

        # Perform other data check
        try:
            # TODO: Code the data check
        except Exception as e:
            output_data.append(f"Unexpected Exception: {e}")
            output_type.append("text")
            status_data.append("FAILURE")
            continue
        if "BooleanToCheck" == True:
            output_data.append(f"{filename} is able to be ...")
            output_type.append("text")
            status_data.append("SUCCESS")
        else:
            output_data.append(f"{filename} cannot be ...")
            output_type.append("text")
            status_data.append("FAILURE")

    # Gather and tally up the results
    successes = sum(x == "SUCCESS" for x in status_data)
    failures = sum(x == "FAILURE" for x in status_data)
    skips = sum(x == "SKIP" for x in status_data)
    output = output_data # Or you can write a custom message
    
    if successes > 0 and failures == 0:
        status = "SUCCESS"
    elif successes == 0 and failures > 0:
        status = "FAILURE"
    else:
        status = "FAILURE" 

    # The array below must be populated in order for the `MetaDIG-py` run_check
    # function to return valid results.
    metadigpy_result["identifiers"] = output_identifiers
    metadigpy_result["output"] = output_data
    metadigpy_result["status"] = status
    return True
```

## License
```
Copyright [2013] [Regents of the University of California]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0:

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

## Acknowledgements
Work on this package was supported by:

- DataONE Network
- NSF ACI - DATANET grant #1443062 to T. Habermann and M. B. Jones

Additional support was provided for collaboration by the National Center for Ecological Analysis and
Synthesis, a Center funded by the University of California, Santa Barbara, and the State of
California.

[![DataONE_footer](https://user-images.githubusercontent.com/6643222/162324180-b5cf0f5f-ae7a-4ca6-87c3-9733a2590634.png)](https://dataone.org)

[![nceas_footer](https://www.nceas.ucsb.edu/sites/default/files/2020-03/NCEAS-full%20logo-4C.png)](https://www.nceas.ucsb.edu)