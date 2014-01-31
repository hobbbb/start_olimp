package Util;

our @ISA = qw(Exporter);
our @EXPORT = qw(&w &send_email);

use strict;
use warnings;

use MIME::Lite;
use MIME::Base64;
use Encode qw/encode/;
use Data::Dumper;

sub w {
    my $p = shift;

    die Dumper $p;
}

sub generate {
    my %params = @_;
    $params{length} ||= 50;

    my @table = $params{light} ? ('A'..'Z','1'..'9','a'..'z') : ('A'..'Z','1'..'9','a'..'z','!','@','#','$','%','^','&','*','(',')');
    my $str = '';
    for(my $i=0; $i < $params{length}; $i++) {
        $str .= $table[int(rand(scalar(@table)))]
    }
    return $str;
}

sub now {
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);

    $year += 1900;
    $mon += 1;

    return "$year-$mon-$mday $hour:$min:$sec";
}

sub send_email {
    my %params = @_;

    # $params{to} = 'p.vasilyev@corp.mail.ru, vvd@programmex.ru' if config->{environment} ne 'production';

    utf8::encode($params{body});
    $params{$_} = encode('MIME-Header', $params{$_}) for qw(to from subject);

    my $msg = MIME::Lite->new(
        From    => $params{from} || 'info',
        To      => $params{to},
        Subject => $params{subject},
        Type    => 'multipart/mixed',
    );
    $msg->attach(
        Type    => 'text/html; charset=UTF-8',
        Data    => $params{body},
    );

    for (@{$params{attachment}}) {
        utf8::encode($_->{Filename});
        $msg->attach(%{$_});
    }

    $msg->send;

    if ($params{attachment_delete}) {
        for (@{$params{attachment}}) {
            unlink $_->{Path} if -f $_->{Path};
        }
    }
}

=c
sub trim {
    my $str = shift;
    $str =~ s/\s+/ /g;
    $str =~ s/^\s+//;
    $str =~ s/\s+$//;
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
