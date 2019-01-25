#!/bin/bash
#title           :realm_finder.sh
#description     :This script will make a directory of symlinks for .
#author		 :John Beoris
#date            :20190125
#version         :0.1    
#usage		 :bash realm_finder.sh
#notes           :Install XCode, Developer Tools, and Realm Studio to make use of this.
#bash_version    :3.2
#==============================================================================

# Where our symlinks will be stored.
realm_files_dir="./realm_files"

# Wipe this directory and recreate it.
rm -rf $realm_files_dir
mkdir $realm_files_dir

# Used to name realm files.
counter=1

# Get directory of Core Simulator devices for current user.
user_name=$(id -un)
devices_dir="/Users/${user_name}/Library/Developer/CoreSimulator/Devices"

# Iterate over each device directory.
devices=$(find $devices_dir -type d -maxdepth 1 -mindepth 1)
for device in $devices
do
  # If application directory exists, access it.
  applications_dir="${device}/data/Containers/Data/Application"
  if [ -d "$applications_dir" ]; then
    # Iterate over each application directory.
    applications=$(find $applications_dir -type d -maxdepth 1 -mindepth 1)
    for application in $applications
    do
      # If realm file exists, create symlink for it and increment counter.
      realm_file="${application}/Documents/default.realm"
      if [ -f "$realm_file" ]; then
        realm_file_sym_link="${realm_files_dir}/realm_file_${counter}.realm"
        ln -s $realm_file $realm_file_sym_link
        ((counter++))
      fi
    done
  fi
done
