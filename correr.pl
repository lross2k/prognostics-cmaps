#!/usr/bin/perl
 
# Decide operating mode based on args
my $mode = @ARGV[0];

my @dir_list = ();
for ($_ = 1; $_ <= 260; $_ = $_ + 1) {
	push(@dir_list, $_);
}

# Generating direcories for all the data files
if ($mode eq 'SETUP') { 	
	foreach $_ (@dir_list) {
		mkdir "Motor$_"
	}
	print "Generated directories\n";
}

# House cleaning operations
if ($mode eq 'CLEAN') {	
	foreach $_ (@dir_list) {
		rmdir "Motor$_";
	}
	print "Removed directories\n";
}

if ($mode eq 'RRUN') {
	system('Rscript split.R train_FD002.csv');	
}
