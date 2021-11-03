#!/bin/bash
# Which of the March sisters is referred to most often in
# part 1 of the Little Women?

# Split lines into words
cat ../inputs/little_women_part_1.txt \
    | tr -cs '[:alpha:]' '\n' \
    > 1.split_words.txt

# Count words
sort 1.split_words.txt | uniq -c \
    > 2.count_words.txt

# Sort words by descending count and add header
sort -k1,1nr 2.count_words.txt \
    | awk 'BEGIN {print "word\tcount"} { print $2 "\t" $1}' \
    > 3.sort_counts.txt

# Select names with respective counts
egrep '^(Jo|Amy|Laurie|Beth)\t' 3.sort_counts.txt > 4.select_words.txt

# Print excerpts of input and results from each step
head ../inputs/little_women_part_1.txt `ls *.txt` | less
