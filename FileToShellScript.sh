# !/bin/bash

echo "Detecting the file."

# The folder must have two files. 
# One this shell file itself and 
# the the media file which will 
# be converted to a executable 
# script file. If there are more 
# than two file, this method 
# fail. This method was not 
# designed in that way. 

File=$(ls | grep -wv FileToShellScript.sh)

echo "The detected file is \"$File\"."

# Start creating the file. 
echo "Generating the file."

# Set the new file name. 
NewFile=$(echo $File.sh)

# Show the user the new file 
# name. 
echo "The new file would be \"$NewFile\"."

cat > "$NewFile" << EOF
# !/bin bash
ARCHIVE=\$(awk '/^__ARCHIVE_BELOW__/{print NR + 1;exit;0;}' \$0)

tail -n+\$ARCHIVE \$0 > "$File"


exit
__ARCHIVE_BELOW__
EOF

# Honestly, I've no idea how 
# the above part of the code 
# works. 

# Now, append the file with the 
# file. 

cat >> "$NewFile" < "$File"

# Make sure that the script 
# file executable.

chmod 755 "$NewFile"