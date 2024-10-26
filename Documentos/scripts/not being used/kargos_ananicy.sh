#!/bin/bash

echo "Ananicy: $(journalctl -u ananicy-cpp.service -n 1 |  awk '{print $9}' | sed "s/[(][^)]*[)]/()/g" | tr -d '()')"
echo "---"
echo "$(journalctl -u ananicy-cpp.service -r -b --output=cat)"
