use strict;
use warnings;

sub generate_string_hash {
    my $str = lc $_[0];
    my @str = split(//, $str);
    @str = sort @str;
    return join ("", @str);
}


my @inp = qw(5th
        ascot
        ate
        carrot
        coast
        coats
        cots
        Dorian
        eat
        halls
        headskin
        inroad
        nakedish
        ordain
        Ronald's
        shall
        sinkhead
        tacos
        tea);

my %word_hash;

# Hash each input in a map
foreach (@inp) {
    my $key = generate_string_hash($_);
    #print "$key\n";
    if (exists $word_hash{$key}) {
        push @{$word_hash{$key}}, $_; 
    }
    else {
        @{$word_hash{$key}} = ($_);
    }
}

# Sort each array alphabetically

foreach (keys %word_hash) {
    if ((scalar @{$word_hash{$_}}) >= 2) {
        @{$word_hash{$_}} = sort {lc ($a) cmp lc($b)} @{$word_hash{$_}};
    }
    else {
        delete $word_hash{$_};
    }
}

# Output what is asked in question
foreach (@inp) {
    my $key = generate_string_hash($_);
    next unless exists $word_hash{$key};
    if ($_ eq $word_hash{$key}[0]) {
        print join(" ", @{$word_hash{$key}}), "\n";
    }
    else {
        if ($word_hash{$key} == 2) {
            print "$word_hash{$key}[1]  $word_hash{$key}[0]\n";
        }
        else {
            print "$_ (See '$word_hash{$key}[0])')\n";
        }
    }
}


