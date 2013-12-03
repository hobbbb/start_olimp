[% IF role.grep('^student|teacher|parent$') %]
    <div class="col-md-5">
        <ul class="nav nav-pills">
            <li [% 'class="active"' IF role == 'student' %]><a href="/auth/register?role=student">Учащийся</a></li>
            <li [% 'class="active"' IF role == 'teacher' %]><a href="/auth/register?role=teacher">Учитель</a></li>
            <li [% 'class="active"' IF role == 'parent' %]><a href="/auth/register?role=parent">Родитель</a></li>
        </ul>

        <h2>Регистрация</h2>
        <form class="form-horizontal" role="form" method="post" action="/auth/register/">
        <input type="hidden" name="role" value="[% role %]">
            <div class="form-group [% 'has-error' IF vars.fail.sex %]">
                <div class="col-sm-offset-2 col-sm-10">
                    <div class="checkbox">
                        <label class="checkbox-inline"><input type="radio" name="sex" value="m" [% 'checked' IF form.sex == 'm' %]> Муж</label>
                        <label class="checkbox-inline"><input type="radio" name="sex" value="f" [% 'checked' IF form.sex == 'f' %]> Жен</label>
                    </div>
                </div>
            </div>
            <div class="form-group [% 'has-error' IF vars.fail.fio %]">
                <label for="fio" class="col-sm-2 control-label">ФИО</label>
                <div class="col-sm-10"><input type="text" class="form-control" id="fio" placeholder="ФИО" name="fio" value="[% form.fio %]"></div>
            </div>
            <div class="form-group [% 'has-error' IF vars.fail.email %]">
                <label for="email" class="col-sm-2 control-label">Email</label>
                <div class="col-sm-10"><input type="email" class="form-control" id="email" placeholder="Email" name="email" value="[% form.email %]"></div>
                [% '<span class="err">Такой E-mail уже существует</span>' IF vars.fail.email_exist %]
            </div>
            <div class="form-group [% 'has-error' IF vars.fail.password %]">
                <label for="password" class="col-sm-2 control-label">Пароль</label>
                <div class="col-sm-10"><input type="password" class="form-control" id="password" placeholder="Пароль" name="password" value="[% form.password %]"></div>
            </div>
            [% IF role == 'student' %]
                <div class="form-group [% 'has-error' IF vars.fail.class_number %]">
                    <label for="class_number" class="col-sm-2 control-label">Класс</label>
                    <div class="col-sm-10"><input type="number" class="form-control" id="class_number" placeholder="Класс" name="class_number" value="[% form.class_number %]" min="1" max="11"></div>
                </div>
            [% ELSIF role == 'teacher' %]
                <div class="form-group [% 'has-error' IF vars.fail.school_number %]">
                    <label for="school_number" class="col-sm-2 control-label">Номер школы</label>
                    <div class="col-sm-10"><input type="text" class="form-control" id="school_number" placeholder="Номер школы" name="school_number" value="[% form.school_number %]"></div>
                </div>
            [% END %]

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10"><button type="submit" class="btn btn-default">Регистрация</button></div>
            </div>
        </form>
    </div>
[% END %]
<!--form action="/auth/register/" method="post">
    <fieldset>
        <h3>Регистрация</h3>
            <label class="label">E-mail:</label>
            <input type="text" name="email" value="[% form.email %]" [% 'class="red"' IF err.email %] />

            <label class="label">ФИО:</label>
            <input type="text" name="fio" value="[% form.fio %]" [% 'class="red"' IF err.fio %] />

            <label class="label">Пароль:</label>
            <input type="text" name="password" value="[% form.password %]" [% 'class="red"' IF err.password %] />

            <li>
                [% '<span class="err">Такой E-mail уже существует</span>' IF err.email_exist %]
            </li>

            <input type="text" name="code" placeholder="5+3" class="dnone" />

            <input value="Зарегистрироваться" type="submit" />
    </fieldset>
</form-->
