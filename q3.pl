use strict;
use warnings;
use Time::Local;

my %months = (
    Jan => 0,
    Feb => 1,
    Mar => 2,
    Apr => 3,
    May => 4,
    Jun => 5,
    Jul => 6,
    Aug => 7,
    Sep => 8,
    Oct => 9,
    Nov => 10,
    Dec => 11,
    );
# Parse date and time from the meassage which is followed by 'Date:'
my $str = << 'END';
Hi,
    This is a test mail.
Regards,
XYZ
SASA Date: Wed, 8 Oct 2016 16:10:15 -0400 DEGF
END
my $pattr = qr/Date:\s+(\w{3}),\s+(\d{1,2})\s+(\w{3})\s+(\d{4})\s+(\d\d:\d\d:\d\d)\s+([+-]\d{4})/;
if ($str =~ $pattr) {
    my $day = $1;
    my $date = $2;
    my $month = $3;
    my $year = $4;
    my $time = $5;
    my $gmt_diff = $6;

    my ($hr, $min, $sec) = split /:/, $time;
# Convert datetime to GMT
    $time = timegm($sec, $min, $hr, $date, $months{$month}, $year);
    my $sign = substr($gmt_diff, 0, 1);
    $gmt_diff = substr($gmt_diff, 1);

    my $gd_hr = substr($gmt_diff, 0, 2);
    my $gd_min = substr($gmt_diff, 2, 2);
    $gmt_diff = $gd_hr * 3600 + $gd_min * 60;
    if ($sign eq "+") {
        $time -= $gmt_diff;
    }
    else {
        $time += $gmt_diff;
    }

# Substract it from current GMT datetime
    my $curr_time = time();
    my $time_diff = $curr_time - $time;

    #print "curr: $curr_time given: $time gmt_diff: $gd_hr:$gd_min diff: $time_diff\n";
# convert it into hours and compare it with 60  and show appropriate message
    $time_diff /= 3600;

    if ($time_diff < 60) {
        my $h = int(60 - $time_diff);
        my $m = int((60 - $time_diff - $h) * 60);
        print "It is too soon to send spoilers for this quiz.\nYou may send spoilers in another $h hours $m minutes."
    }
    else {
        print "It is okay to send spoilers for this quiz\n";
    }
}
