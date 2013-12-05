package Errors;

our @ISA = qw(Exporter);
our @EXPORT = qw(&fail);

use Dancer ':syntax';
use Util;

sub fail {
    my $err = shift;

    my $fail = vars->{fail};

    if ($err) {
        $fail->{$err} = 1;
        var fail => $fail;
    }
    else {
        return $fail;
    }
}
