#!/bin/bash
# Script to upload the ipa file to App Store Connect

# Exit immediately if any command fails
set -e

# Loading animation function
loading_animation() {
  local pid=$1
  local delay=0.1
  local spinstr='|/-\' # Simple ASCII spinner
  while kill -0 $pid 2>/dev/null; do
    local temp=${spinstr#?}
    printf "\r[%c] Uploading to TestFlight... (elapsed: %ds)" "$spinstr" "$SECONDS"
    local spinstr=$temp${spinstr%"$temp"}
    sleep $delay
  done
  printf "\r"
}

# Start timer
SECONDS=0

APP_STORE_CONNECT_KEY_ID=J7AF8P7FQM
APP_STORE_CONNECT_ISSUER_ID=edbb75af-0c87-4dc9-9f44-b637c1ae53bc

# Validate that the API Key ID and Issuer ID are set
if [[ -z ${APP_STORE_CONNECT_KEY_ID} ]]; then
  echo "❌ Please set APP_STORE_CONNECT_KEY_ID as an environment variable."
  exit 1
fi

if [[ -z ${APP_STORE_CONNECT_ISSUER_ID} ]]; then
  echo "❌ Please set APP_STORE_CONNECT_ISSUER_ID as an environment variable."
  exit 1
fi

echo "🔑 Setting up authentication..."

# Create private_keys directory if it doesn't exist
mkdir -p ~/.appstoreconnect/private_keys

# Copy the auth key to the correct location
cp tools/script/AuthKey_J7AF8P7FQM.p8 ~/.appstoreconnect/private_keys/

# Find the IPA file
IPA_PATH=$(ls build/ios/ipa/*.ipa)
if [ ! -f "$IPA_PATH" ]; then
  echo "❌ No IPA file found in build/ios/ipa/"
  exit 1
fi

echo "🔍 Checking certificate validity..."

# Create temporary directory
TEMP_DIR=$(mktemp -d)

# Extract IPA
unzip -q "$IPA_PATH" -d "$TEMP_DIR"

# Find .app bundle
APP_BUNDLE=$(find "$TEMP_DIR/Payload" -name "*.app" -type d)
if [ -z "$APP_BUNDLE" ]; then
  echo "❌ No .app bundle found in the IPA."
  rm -rf "$TEMP_DIR"
  exit 1
fi

# Verify code signature
CODESIGN_OUTPUT=$(codesign -vvv --verify "$APP_BUNDLE" 2>&1)
CODESIGN_STATUS=$?
if [ $CODESIGN_STATUS -ne 0 ]; then
  echo "❌ Certificate validation failed."
  echo "📋 codesign output:"
  echo "$CODESIGN_OUTPUT"
  rm -rf "$TEMP_DIR"
  exit 1
fi

echo "✅ Certificate is valid."

# Clean up temporary directory
rm -rf "$TEMP_DIR"

# Upload the IPA file to App Store Connect using xcrun
echo "📤 Starting upload process..."
echo "⏳ This might take a few minutes..."

# Run upload in background and capture its PID
xcrun altool --upload-app \
  --type ios \
  --file "$IPA_PATH" \
  --apiKey "${APP_STORE_CONNECT_KEY_ID}" \
  --apiIssuer "${APP_STORE_CONNECT_ISSUER_ID}" >upload.log 2>&1 &

upload_pid=$!

# Start loading animation
loading_animation $upload_pid

# Wait for upload to complete
wait $upload_pid

# Calculate duration
duration=$SECONDS
minutes=$((duration / 60))
seconds=$((duration % 60))

# Check upload result
if [ $? -eq 0 ]; then
  clear
  echo "✅ Successfully uploaded to TestFlight"
  echo "⏱️  Upload completed in ${minutes}m ${seconds}s"
else
  echo "❌ Failed to upload to TestFlight"
  echo "⏱️  Failed after ${minutes}m ${seconds}s"
  echo "📋 Error log:"
  cat upload.log
  exit 1
fi

# Cleanup
rm upload.log
