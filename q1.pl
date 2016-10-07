use warnings;
use strict;

use feature 'say';

sub center {
	my $max_len = 0;
	for my $s (@_) {
        if ($max_len < length $s) {
            $max_len = length $s;
        }
    }

	for (my $i=0; $i < @_ ; $i++) {
        my $spaces = ($max_len - (length $_[$i]) + 1) / 2;
        my $pre = "";
        for (1 .. $spaces) {
            $pre = $pre . " ";
        }
        $_[$i] = $pre . $_[$i];
    }
}

#my @arr = ("a", "aaa","aaaaa", "aaaaaaa");
my @arr = ("This", "is", "a test of the", "center function");
my $len = center(@arr);

for my $s (@arr) {
    say $s;
}
