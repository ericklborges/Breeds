#!/bin/bash
NC="\033[0m"
LINK="\033[1;4m"
HIGHLIGHT="\033[1;32m"
FILE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo -e "Breeds needs a private key to TheDogAPI, you can get it at: ${LINK}https://thedogapi.com${NC}\n"
echo -e "What is the key for ${HIGHLIGHT}TheDogAPI${NC}"
read -p "> the_dog_api_key " TheDogAPIKey

cd ${FILE_DIR}/Breeds

cat > Secrets.plist << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>TheDogAPIKey</key>
	<string>$TheDogAPIKey</string>
</dict>
</plist>
EOF
