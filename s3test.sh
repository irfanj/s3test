##### RUN THIS FROM OUTSIDE OF AWS (ie desktop)

# create 10Mb test file
tfile=testdata.bin
dd if=/dev/zero of=${tfile} bs=10485760 count=1

# create buckets
s3cmd mb s3://ULTEST_DELAY
s3cmd mb s3://ULTEST_NODELAY
s3cmd mb s3://ultest-delay
s3cmd mb s3://ultest-nodelay

# upload the test file to our 'nodelay' buckets
s3cmd put ${tfile} s3://ULTEST_NODELAY
s3cmd put ${tfile} s3://ultest-nodelay

# wait for 3 hours and then upload the test data to the 'delay' buckets
sleep 3h
s3cmd put ${tfile} s3://ULTEST_DELAY
s3cmd put ${tfile} s3://ultest-delay



#### RUN THESE FROM AN EC2 INSTANCE

# fetch the files back and look at the download times.
# for fairness you should do this multiple times and average,
# but you should see the same result
s3cmd get s3://ULTEST_NODELAY/${tfile} tmp.1
s3cmd get s3://ultest-nodelay/${tfile} tmp.2
s3cmd get s3://ULTEST_DELAY/${tfile} tmp.3
s3cmd get s3://ultest-delay/${tfile} tmp.4


#### CLEANUP
# delete files
s3cmd del s3://ULTEST_DELAY/${tfile}
s3cmd del s3://ULTEST_NODELAY/${tfile}
s3cmd del s3://ultest-delay/${tfile}
s3cmd del s3://ultest-nodelay/${tfile}

# delete buckets
s3cmd rb s3://ULTEST_DELAY
s3cmd rb s3://ULTEST_NODELAY
s3cmd rb s3://ultest-delay
s3cmd rb s3://ultest-nodelay

# delete tmp files
rm -f tmp.* testdata.bin


