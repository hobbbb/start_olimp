package Errors;

our @ISA = qw(Exporter);
our @EXPORT = qw(&fail &failed);

use Dancer ':syntax';
use Util;

sub fail {
    my $err = shift;

    my $fail = vars->{fail};

    if ($err) {
        $fail->{$err} = 1;
        var fail => $fail;
    }
}

sub failed {
    my $k = shift;

    my $fail = vars->{fail};

    if ($k) {
        return $fail->{$k};
    }
    else {
        return $fail;
    }
}
