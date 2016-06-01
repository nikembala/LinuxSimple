#!/bin/bash


declare _infile1='DEV.txt'
declare _infile2='QA.txt'


# a bit of security flaw
touch ./.sorted_and_ordered_1
touch ./.sorted_and_ordered_2


# the real deal
sed 's/\["\(.*\)"\]/\1/g' ${_infile1} | awk -F '"."' '{
    for (i = 1; i <= NF; i++) {
        for (j = 1; j <= NF; j++) {
            if ($i < $j) {
			    a = $i;
				$i = $j;
				$j = a;
			}
        }
    }
	print
}' | sort > ./.sorted_and_ordered_1

sed 's/\["\(.*\)"\]/\1/g' ${_infile2} | awk -F '"."' '{
    for (i = 1; i <= NF; i++) {
        for (j = 1; j <= NF; j++) {
            if ($i < $j) {
			    a = $i;
				$i = $j;
				$j = a;
			}
        }
    }
	print
}' | sort > ./.sorted_and_ordered_2

echo 'diff result:' # 1 vs 2:'
diff ./.sorted_and_ordered_1 ./.sorted_and_ordered_2
if [ $? -eq 0 ]; then echo "all is OK"; fi


# clean up
rm -f ./.sorted_and_ordered_1
rm -f ./.sorted_and_ordered_2