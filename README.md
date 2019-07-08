Usage
-----

Specify observable to search as an argument or mount a file with new line separated observables to the following path inside container `/data/iocs.txt`.

Examples:
```
    docker build -t mwls github.com/security-dockerfiles/misp-warninglists.git
    docker run -it --rm mwls 8.8.8.8
    docker run -it --rm $PWD/iocs.txt:/data/iocs.txt mwls
```
