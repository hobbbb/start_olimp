package Ctrl::User::Interest;

use Dancer ':syntax';
use Util;

use Interest;

get '/' => sub {
    my $user = vars->{loged} or StartOlimp::not_found();
    my $list = Interest->list_by_user_rh($user->interest_list());
    return template 'interest', { list => $list };
};

post '/' => sub {
    my $user = vars->{loged} or StartOlimp::not_found();
    $user->interest_save(params->{interest});
    return redirect '/user/interest/';
};

true;
