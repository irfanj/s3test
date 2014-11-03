## Faster S3 -> EC2 Tranfers

My colleague Matthew at AuriQ systems figured out why some S3 buckets were 
slower in transferring data to an EC2 instance than others.

In short the issue seems to be related to creating buckets and uploading data from
outside of AWS (i.e. using S3cmd from your desktop).

This repo contains some test code so you can replicate the issue 
(we only tested on US-EAST-1) and a pdf describing the situation in more detail.


