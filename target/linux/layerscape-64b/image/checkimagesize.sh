#!/bin/bash
#
# Licensed under the terms of the GNU GPL License version 2 or later.
#
# $(1) source image name
# $(2) partition image size(M)

SOURCE_IMAGE_SIZE=`du -b $1 | awk '{print $1}'`
PARTITION_IMAGE_SIZE=`expr $2 \* 1024 \* 1024`

if [ $SOURCE_IMAGE_SIZE -gt $PARTITION_IMAGE_SIZE ]; then
	echo "error: $1 too large than limited $2(M)"
	exit 1
else
	exit 0
fi
