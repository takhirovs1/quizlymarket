#!/bin/bash

# Define paths for key.properties and keystore (.jks) file
KEY_PROPERTIES_FILE="android/key.properties"
JKS_FILE_PATTERN="*.jks"
JKS_FILE_PATH="android/app"
DEFAULT_KEYSTORE_NAME="release-key.jks"

# Define keystore details
KEYSTORE_PASSWORD="udevs_initial_project"
KEY_PASSWORD="udevs_initial_project"
KEY_ALIAS="release"
VALIDITY=10000

# Check if key.properties file exists
if [ -f "$KEY_PROPERTIES_FILE" ]; then
    echo "✅ key.properties file found at $KEY_PROPERTIES_FILE"
else
    echo "❌ key.properties file not found."
    echo "Generating a default key.properties file..."

    # Generate default key.properties file
    cat <<EOL > $KEY_PROPERTIES_FILE
storePassword=$KEYSTORE_PASSWORD
keyPassword=$KEY_PASSWORD
keyAlias=$KEY_ALIAS
storeFile=$DEFAULT_KEYSTORE_NAME
EOL
    echo "✅ Default key.properties file created at $KEY_PROPERTIES_FILE"
fi

# Check if .jks file exists in the specified path
JKS_FILE=$(find "$JKS_FILE_PATH" -name "$JKS_FILE_PATTERN" -print -quit)

if [ -n "$JKS_FILE" ]; then
    echo "✅ Keystore file (.jks) found at $JKS_FILE"
else
    echo "❌ Keystore file (.jks) not found."

    # Generate a new keystore
    echo "Generating a new keystore..."
    keytool -genkey -v \
        -keystore "$JKS_FILE_PATH/$DEFAULT_KEYSTORE_NAME" \
        -keyalg RSA \
        -keysize 2048 \
        -validity $VALIDITY \
        -alias $KEY_ALIAS \
        -storepass $KEYSTORE_PASSWORD \
        -keypass $KEY_PASSWORD \
        -dname "CN=Unknown, OU=Unknown, O=Unknown, L=Unknown, ST=Unknown, C=Unknown"

    if [ $? -eq 0 ]; then
        echo "✅ New keystore generated at $JKS_FILE_PATH/$DEFAULT_KEYSTORE_NAME"
    else
        echo "❌ Failed to generate new keystore"
    fi
fi

echo "All necessary checks and setups are done."
