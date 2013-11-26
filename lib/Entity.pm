package Entity;

use Dancer ':syntax';
use Dancer::Plugin::Database;
use Mouse;
use Carp;
use Data::Dumper;

has id  => (is => 'ro', isa => 'Int');

sub list {
    my ($class, $cond) = @_;
    $cond ||= {};

    my $list = [ database->quick_select($class->_tname, $cond) ];
    return map { $class->new($_) } @$list;
}

sub get {
    my ($class, $id) = @_;

    my $o = database->quick_select($class->_tname, { id => $id }) || {};
    return $class->new($o);
}

sub _tname {
    my ($invocant) = @_;
    my $name = ref($invocant) || $invocant;
    $name =~ s/::/_/g;
    return $name;
}

__PACKAGE__->meta->make_immutable();
