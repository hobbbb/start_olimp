<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Bug Tracker</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Le styles -->
    <link rel="stylesheet" href="/css/error.css">
    <link rel="stylesheet" href="/css/bootstrap.css">
    <link rel="stylesheet" href="/css/smoothness/jquery-ui.css" />
    <link rel="stylesheet" href="/css/main.css" />

    <script type="text/javascript" src="/javascripts/jquery.js?v=2013_08_30_13_20"></script>
    <script type="text/javascript" src="/javascripts/jquery-migrate-1.2.1.js"></script>
    <script type="text/javascript" src="/javascripts/jquery-ui.js?v=2013_05_22_23_50"></script>
    <script type="text/javascript" src="/javascripts/bootstrap.js"></script>
    <script type="text/javascript" src="/javascripts/main.js?v=2013-09-20_09_10"></script>
    <script type="text/javascript" src="/ckeditor/ckeditor.js"></script>
</head>

<body>
    <div class="navbar navbar-inverse navbar-fixed-top">
        <div class="navbar-inner">
        <div class="container-fluid">
            <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <div class="nav-collapse collapse">
                <ul class="nav">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Баги <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="/bugs/?filter_status=todo">Новые</a></li>
                            <li><a href="/bugs/?filter_status=done">Сделанные</a></li>
                        </ul>
                    </li>
                </ul>
            </div><!--/.nav-collapse -->
        </div>
        </div>
    </div>

    <div class="container-fluid">
        [% content %]
    </div>

</body>
</html>
