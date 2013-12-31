package Record;

use Mouse;

use Dancer ':syntax';
use Dancer::Plugin::Database;
use Util;

has id => (is => 'rw', isa => 'Int');

sub take {
    my ($class, $id) = @_;
    return $class->list({ id => $id });
}

sub list {
    my ($class, $cond) = @_;
    $cond ||= {};

    my $list = [ database->quick_select($class->_table, $cond) ];

    if (scalar @$list == 1) {
        return wantarray ? map { $class->new($_) } @$list : $class->new($list->[0]);
    }
    else {
        return map { $class->new($_) } @$list;
    }
}

sub count {
    my ($class, $cond) = @_;
    $cond ||= {};

    return database->quick_count($class->_table, $cond);
}

sub create {
    my ($class, %params) = @_;
    return $class->_insert(%params);
}

sub save {
    my ($self, %params) = @_;
    return $self->_update(%params);
}

sub remove {
    my ($invocant, $id) = @_;
    if (ref($invocant)) {
        return ref($invocant)->_delete;
    }
    elsif ($id) {
        my $self = $invocant->take($id) or return;
        return $self->_delete;
    }
}

sub as_vars {
    my $self = shift;
    return +{ %$self };
}

sub merge_params {
    my ($invocant, %params) = @_;
    my %merge = %params;

    if (ref($invocant)) {
        %merge = %$invocant;
        for my $k (keys %params) {
            $merge{$k} = $params{$k};
        }
    }

    return %merge;
}

### CORE

sub _insert {
    my ($class, %params) = @_;

    %params = $class->_clear_params(%params) or return;
    if ($class->can('validate')) {
        return unless $class->validate(%params);
    }

    my $self = $class->new(%params);
    my $res = database->quick_insert($class->_table, { %$self });

    if ($res ne '0E0') {
        my $id = database->last_insert_id(undef, undef, undef, undef);
        $self->id($id);
        return $self;
    }
}

sub _update {
    my ($self, %params) = @_;
    return unless $self->id;

    %params = $self->_clear_params(%params) or return;
    for my $k (keys %params) {
        $self->$k($params{$k});
    }
    if ($self->can('validate')) {
        return unless $self->validate(%params);
    }
    my $res = database->quick_update($self->_table, { id => $self->id }, { %$self });

    return $res eq '0E0' ? undef : $self;
}

sub _delete {
    my $self = shift;
    my $res = database->quick_delete($self->_table, { id => $self->id });
    return $res eq '0E0' ? undef : 1;
}

sub _clear_params {
    my ($invocant, %params) = @_;
    my $class = ref($invocant) || $invocant;

    for my $k (keys %params) {
        unless (grep(/^$k$/, $class->meta->get_attribute_list)) {
            delete $params{$k};
        }
    }
    return keys %params ? %params : undef;
}

sub _table {
    my ($invocant) = @_;
    my $name = ref($invocant) || $invocant;
    $name =~ s/^Record:://;
    $name =~ s/::/_/g;
    return $name;
}

__PACKAGE__->meta->make_immutable();
