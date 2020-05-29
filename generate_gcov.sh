#! /bin/sh
# Create the folders to ensure folder existence.
if [ ! -d ./coverage/  ]; then mkdir -p ./coverage/ ;fi
if [ ! -d ./gcov/  ]; then mkdir -p ./gcov/ ;fi

# Going through ./gcov
cd ./gcov

# Search in the project all gcno files and make a gcov on them
gcno_files=$(find ../../ -type f -name "*.gcno")
for filename in $gcno_files
do
     orig_name=$(echo "$filename" | sed 's!.*/!!')
     echo "gcovving" "$orig_name"
	 $(gcov -a -f -c -m -b $gcno_files > /dev/null)
done

# Going out to ./
cd ../

# gcovr it!
gcovr -r ./ --xml -o ./coverage/coverage.xml

# Exit pacefully
echo "done gcovving"
