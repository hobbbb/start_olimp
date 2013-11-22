package SPE::bugs;

use Dancer ':syntax';

my $settings = {
    script      => '/bugs/',
    tpl         => 'SPE.tpl',
    alias       => 'bugs',
    upload      => 1,
    sortable    => 1,
    title       => 'Баги / Доработки',
    fields      => [
        # {
        #     name    => 'priority',
        #     type    => 'select',
        #     vals    => [ crit => 'Крит']
        #     descr   => 'Приоритет',
        #     error   => sub { !grep(/^$_[0]$/, qw/crit norm low/) },
        # },
        {
            name    => 'descr',
            type    => 'editor',
            descr   => 'Описание',
            in_list => 1,
            error   => sub { !length(shift) },
        },
        {
            name    => 'status',
            type    => 'select',
            vals    => [{ todo => 'Новый' }, { done => 'Сделан' }],
            descr   => 'Статус',
            error   => sub { !grep(/^$_[0]$/, qw/todo done/) },
        },
    ],
};

any '/'            => sub { return SCM::SPE::main($settings, \%{params()}); };
any '/edit/:id/'   => sub { return SCM::SPE::edit($settings, \%{params()}); };
any '/del/:id/'    => sub { return SCM::SPE::del($settings, \%{params()}); };
any '/rearrange/'  => sub { return SCM::SPE::rearrange($settings, \%{params()}); };

true;
