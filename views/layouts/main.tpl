<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>StartOlimp</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Le styles -->
    <link rel="stylesheet" href="/css/bootstrap.css">
    <link rel="stylesheet" href="/css/navbar-fixed-top.css">
    <!--link rel="stylesheet" href="/css/smoothness/jquery-ui.css?v=2013_05_22_23_50" />
    <link rel="stylesheet" href="/css/admin.css?v=2013_09_17_10_00"-->

    <script type="text/javascript" src="/javascripts/jquery.js?v=2013_08_30_13_20"></script>
    <script type="text/javascript" src="/javascripts/jquery-migrate-1.2.1.js"></script>
    <script type="text/javascript" src="/javascripts/bootstrap.js"></script>

    <link rel="shortcut icon" href="[% request.uri_base %]/favicon.ico">
</head>

<body>
<div class="container">

    <!-- Static navbar -->
    <div class="navbar navbar-default" role="navigation">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="/">Старт Олимп</a>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li><a href="/auth/register">Регистрация</a></li>
                <!--li class="active"><a href="#">Link</a></li>
                <li><a href="#">Link</a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="#">Action</a></li>
                        <li><a href="#">Another action</a></li>
                        <li><a href="#">Something else here</a></li>
                        <li class="divider"></li>
                        <li class="dropdown-header">Nav header</li>
                        <li><a href="#">Separated link</a></li>
                        <li><a href="#">One more separated link</a></li>
                    </ul>
                </li-->
            </ul>
            [% IF vars.loged %]
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="/auth/logout/">Выйти</a></li>
                </ul>
            [% ELSE %]
                <form class="navbar-form navbar-right" method="post" action="/auth/login/">
                    <div class="form-group">
                        <input type="text" name="email" placeholder="Email" class="form-control">
                    </div>
                    <div class="form-group">
                        <input type="password" name="password" placeholder="Пароль" class="form-control">
                    </div>
                    <button type="submit" class="btn btn-success">Войти</button>
                </form>
            [% END %]
        </div><!--/.navbar-collapse -->
    </div>

    <!-- Main component for a primary marketing message or call to action -->
    <div class="row">
        [% content %]
    </div>

</div> <!-- /container -->
</body>
</html>
