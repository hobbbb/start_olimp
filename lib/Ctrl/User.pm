package Ctrl::User;

use Dancer ':syntax';

load_app 'Ctrl::User::Profile', prefix => '/user/profile';
load_app 'Ctrl::User::Interest', prefix => '/user/interest';

true;
