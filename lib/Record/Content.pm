package Record::Content;

use Mouse;

use Util;
use Errors;

extends 'Record';

has name  => (is => 'rw', isa => 'Str', required => 1);
has descr => (is => 'rw', isa => 'Str', required => 1);

sub validate {
    my ($class, $params, $opt) = @_;
    $opt ||= {};

    for (qw/name descr/) {
        fail $_ unless $params->{$_} and length($params->{$_}) >= 3;
    }

    return failed() ? 0 : 1;
}

__PACKAGE__->meta->make_immutable();
