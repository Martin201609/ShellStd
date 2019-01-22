#!/bin/bash

#######
### fsize.sh  检测大于200M的文件，并显示告警
######


LOGDIR=/app/logs/dir
TEMPFILE=/tmp/tempfile.txt
CHECKSIZE=200


cd $LOGDIR
#ls -l |grep *log*|awk -F '' {print $5," ",$9}

du -sm *|sort -n -k1 >$TEMPFILE


# 变量i用于计算偶数和奇数行，变量j用于结果for循环
i=0
j=`cat $TEMPFILE|wc -l`

#j=$[$j+$j]

#

echo "### Starting Check File Size ....."
echo " "
echo " "
#for item in `ls -l|sort -n -k5|awk -F ' ' '{print $5," ",$9}'`

for item in $(cat $TEMPFILE)
do
    # echo "item: $item  "

    NUM=$i

    fsize=$(awk 'NR=='$NUM' {print $1}' $TEMPFILE)
    fname=$(awk 'NR=='$NUM' {print $2}' $TEMPFILE)



    # echo "$fsize : $fname"
    if [[ $fsize -gt $CHECKSIZE ]]; then
        #statements
        echo "File: $fname  > $CHECKSIZE MB ,Warninig !!"
        echo "File: $fname Fsize: $fsize MB"
        echo ""

    fi

    i=$[$i+1]

    # echo "for i : $i"
    if [[ $i -gt $j ]]; then
        #statements
        echo " "
        echo "### File Size Check Recursive done ,exit the scipts~"
       #    rm $TEMPFILE
        exit 1
    fi

done



# 思路2 ： 也可以使用for的数字循环，判断行数据 j为最大值
