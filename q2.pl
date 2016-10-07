#Solution is not complete and does not work for many cases
use strict;
use warnings;

my %months = (
    Jan => 1,
    Feb => 2,
    Mar => 3,
    Apr => 4,
    May => 5,
    Jun => 6,
    Jul => 7,
    Aug => 8,
    Sept =>9,
    Oct => 10,
    Nov => 11,
    Dec => 12,
);

sub is_leap_year {
    my $year = $_[0];
    if ($year % 4 == 0) {
        if ($year % 100 != 0) {
            return 1;
        }
        elsif ($year % 400 == 0) {
            return 1;
        }
    }
    return 0;
}
sub get_days_in_month {
    my $month_no = $_[0];
    my $year_no = $_[1];
    if ($month_no == 2) {
        if (is_leap_year($year_no)) {
            return 29;
        }
        return 28;
    }

    if ($month_no <= 7) {
        if ($month_no % 2 == 1) {
            return 31;
        }
        return 30;
    }
    else {
        if ($month_no % 2 == 0) {
            return 31;
        }
        return 30;
    }
}

sub get_days_in_year {
    my $year = $_[0];
    if (is_leap_year($year)) {
        return 366;
    }
    return 365;
}

sub days_diff {
    my $date1 = $_[0];
    my $date2 = $_[1];

    my ($t1, $month1, $day1, $year1) = split(/ /, $date1);
    my ($t2, $month2, $day2, $year2) = split(/ /, $date2);

    my $diff = 0;
    # day diff
    $diff = $day2 - $day1;
    
    # month diff
    for my $i ($months{$month1} .. ($months{$month2} - 1)) {
        $diff += get_days_in_month($i);
    }

    # year diff
    for my $i ($year1 .. ($year2 - 1)) {
        $diff += get_days_in_year($i);
    }
    return $diff;
}

my $date1 = "Wed Oct 16 2002";
my $date2 = "Wed Oct 16 2001";

print days_diff($date1, $date2);





