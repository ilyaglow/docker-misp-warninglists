#!/usr/bin/env python

import json
import os
import sys
from pymispwarninglists import WarningLists

IOCS_FILE = "/data/iocs.txt"
USAGE = """
Specify observable to search as an argument or mount a file {0} with new line separated observables.
Examples:
    docker run -it --rm ilyaglow/mwls 8.8.8.8
    docker run -it --rm $PWD/iocs.txt:{0} ilyaglow/mwls
""".format(IOCS_FILE)

def lookup(indicator):
    results = wl.search(indicator)
    output = {}
    output["value"] = indicator
    output["lists"] = []
    for r in results:
        output["lists"].append(r.name)

    return output

if __name__ == "__main__":
    iocs_from_file = False

    wl = WarningLists(True)

    if os.path.isfile(IOCS_FILE):
        iocs_from_file = True

    if iocs_from_file:
        with open(IOCS_FILE) as f:
            for line in f:
                print(json.dumps(lookup(line.strip())))
        sys.exit()

    if len(sys.argv) != 2:
        print(USAGE)
        sys.exit(1)

    print(json.dumps(lookup(sys.argv[1])))
