<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Админка</title>
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
    <script type="text/javascript" src="/javascripts/jquery-ui.js?v=2013_05_22_23_50"></script>
    <script type="text/javascript" src="/javascripts/bootstrap.js"></script>
    <!--script type="text/javascript" src="/javascripts/admin.js?v=2013_10_28_13_50"></script-->
    <script type="text/javascript" src="/ckeditor/ckeditor.js"></script>

    <link rel="shortcut icon" href="[% request.uri_base %]/favicon.ico">
</head>

<body>
    <!-- Fixed navbar -->
    <div class="navbar navbar-default navbar-fixed-top" role="navigation">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="/">Олимп</a>
            </div>
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <!--li class="active"><a href="#">Home</a></li>
                    <li><a href="#contact">Contact</a></li-->
                    <li><a href="/admin/users/">Пользователи</a></li>
                    <!--li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Раздел <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="#">Пункт 1</a></li>
                            <li class="divider"></li>
                            <li class="dropdown-header">Подраздел</li>
                            <li><a href="#">Что-то еще</a></li>
                        </ul>
                    </li-->
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <!--li><a href="../navbar/">Default</a></li>
                    <li><a href="../navbar-static-top/">Static top</a></li>
                    <li class="active"><a href="./">Fixed top</a></li-->
                </ul>
            </div><!--/.nav-collapse -->
        </div>
    </div>

    <div class="container">
        [% content %]
    </div> <!-- /container -->
</body>
</html>
