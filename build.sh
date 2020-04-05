#/usr/bin/env bash

# Build a one-file executable with pyinstaller
# Assume this is being run in the docker container, so everything we need
# ought already be installed. If not, it should be added to the Dockerfile

# Assume we are running from the folder containing this script
echo "Running from $(pwd)"

python3 -m pipenv install

python3 -m pipenv run python3 -m PyInstaller --onefile ./ft-update.py

# Upload the artifact to the latest tagged release
./upload.sh github_api_token=$GH_API_KEY owner=darrenmsmith repo=FT-WEB tag=LATEST filename=./dist/ft-update