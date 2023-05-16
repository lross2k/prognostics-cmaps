#!/usr/bin/perl

use File::Copy;
use File::Path;
 
# Decide operating mode based on args
my $mode = @ARGV[0];

my @dir_list = ();
for ($_ = 1; $_ <= 260; $_ = $_ + 1) {
	push(@dir_list, $_);
}

# House cleaning operations
if ($mode eq 'CLEAN') {	
	foreach $_ (@dir_list) {
		rmtree "Motor$_";
	}
	print "Removed directories\n";
}

if ($mode eq 'RRUN') {
	system('Rscript split.R train_data.csv');
	print "Splitted data\n\n";
	foreach $_ (@dir_list) {
		print "### Motor$_ ###\n";
		mkdir "Motor$_";
		move("Motor$_.csv", "Motor$_/Motor$_.csv");
		system("Rscript normalize.R Motor$_/Motor$_.csv Motor$_/NormalizedMotor$_.csv");
		print "Normalization done\n";
		system("Rscript regresion.R Motor$_/NormalizedMotor$_.csv Motor$_/RegressionMotor$_.csv");
		print "Regression done\n";
		system("Rscript plotting.R Motor$_/ Motor$_.csv");
		print "Plotting done\n\n";
	}
}
