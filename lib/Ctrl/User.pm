package Ctrl::User;

use Dancer ':syntax';

load_app 'Ctrl::User::Profile', prefix => '/user/profile';
# load_app 'Ctrl::User::Mail', prefix => '/user/mail';

true;
