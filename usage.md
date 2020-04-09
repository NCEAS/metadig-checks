## Using metadig-checks: MetaDIG suites and checks for data and metadata improvement and guidance.

### Building a metadig-checks distribution

A metadig-checks distribution tar file can be built with these steps:

1. Edit the *build.properties* file and edit the `suites` property, specifying a comma
separated list of suites to include in the distribution. 
2. Edit the *metadig-checks.version* property, specifying a release version
that follows the symantic versioning guidelines, for example, as detailed
at https://semver.org/
3. Build the distribution using the `ant` command:

		ant dist

4. Deploy the distribution. For the metadig-engine running on Kubernetes, the base
directory is /data/metadig. Copy this distribution tar file to this directory and
extract it with a command such as *tar xvf <tar archive>*, for example

		tar xvf metadig-checks-0.1.0.tar

