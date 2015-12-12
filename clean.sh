#!/bin/bash
read -r -p "Are you sure you want to delete the build artifacts? [y/N] " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then
    echo "Deleting build artifacts"
    rm -rf build install
    echo "Done"
else
    echo "Nothing deleted"
fi
