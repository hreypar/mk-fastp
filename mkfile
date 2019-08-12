# DESCRIPTION:
# mk module to filter single-end reads in FASTQ files
#
# USAGE:
# Single target execution: `mk <TARGET>` where TARGET is
# any line printed by the script `bin/mk-targets`
#
# Multiple target execution in tandem `bin/mk-targets | xargs mk`
#
# AUTHOR: HRG
#
# run fastp on the *.fastq.gz files in data
#
results/%_fastp_filtered.fastq.gz:   data/%.fastq.gz
	DIR="`dirname $target | sort -u`"
	mkdir -p "$DIR"
	fastp -i  $prereq \
		--stdout \
		--json results/$stem.json \
		--html results/$stem.html \
	| gzip \
		-f \
		--best \
	> $target.build \
	&& mv $target.build $target

