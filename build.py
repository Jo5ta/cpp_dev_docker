#!/usr/bin/env python3
#%%
import urllib.request
import json
import subprocess

# Set the URL of the Docker Hub registry API
url = 'https://registry.hub.docker.com/v2/repositories/jo5ta/cpp_dev_docker/tags/'

# Make a request to the API and decode the JSON response
response = urllib.request.urlopen(url).read().decode('utf-8')
data = json.loads(response)
data = data['results']
data = filter(lambda e : e['name'] != 'latest', data)
data = sorted(data, key = lambda e : e['last_updated'], reverse=True)

# Extract the version ID of the latest tag and increment the minor version
latest_version = data[0]['name']
major_version, minor_version, *_ = latest_version.split('.')
minor_version = int(minor_version) + 1

# Build and tag the Docker image
image_name = f"jo5ta/cpp_dev_docker:{major_version}.{minor_version:02d}"
command = f"docker build -t {image_name} -f cpp_dev_docker.dockerfile ."
subprocess.run(command, shell=True, check=True)
print("done")
