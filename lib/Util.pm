package Util;

our @ISA = qw(Exporter);
our @EXPORT = qw(&w);

use Data::Dumper;

sub w {
    my $p = shift;

    die Dumper $p;
}

sub generate {
    my $length = $_[0] || 50;
    my @table = ('A'..'Z','1'..'9','a'..'z','!','@','#','$','%','^','&','*','(',')');
    my $str = '';
    for(my $i=0; $i<$length; $i++) {
        $str .= $table[int(rand(scalar(@table)))]
    }
    return $str;
}

sub trim {
    my $str = shift;
    $str =~ s/\s+/ /g;
    $str =~ s/^\s+//;
    $str =~ s/\s+$//;
    return $str;
}

sub now {
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);

    $year += 1900;
    $mon += 1;

    return "$year-$mon-$mday $hour:$min:$sec";
}

=c
sub generate_light {
    my $length = 10;
    my @table = ('A'..'Z','1'..'9','a'..'z');
    my $str = '';
    for(my $i=0; $i<$length; $i++) {
        $str .= $table[int(rand(scalar(@table)))]
    }
    return $str;
}

sub escape_html {
    my $str = shift;

    $str =~ s/&/&amp;/g;
    $str =~ s/"/&quot;/g;
    $str =~ s/'/&apos;/g;
    $str =~ s/>/&gt;/g;
    $str =~ s/</&lt;/g;

    return $str;
}
=cut

1;
