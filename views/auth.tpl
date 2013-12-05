: cascade layouts::main
: around content -> {

    <div class="col-md-5">
        <ul class="nav nav-pills">
            <li <: if $role == 'student' { :> class="active" <: } :>><a href="/auth/register?role=student">Учащийся</a></li>
            <li <: if $role == 'teacher' { :> class="active" <: } :>><a href="/auth/register?role=teacher">Учитель</a></li>
            <li <: if $role == 'parent' { :> class="active" <: } :>><a href="/auth/register?role=parent">Родитель</a></li>
        </ul>

        <h2>Регистрация</h2>
        <form class="form-horizontal" role="form" method="post" action="/auth/register/">
        <input type="hidden" name="role" value="<: $role :>">
            <div class="form-group <: if $fail.sex { :> has-error <: } :>">
                <div class="col-sm-offset-2 col-sm-10">
                    <div class="checkbox">
                        <label class="checkbox-inline"><input type="radio" name="sex" value="m" <: if $form.sex == 'm' { :> checked <: } :>> Муж</label>
                        <label class="checkbox-inline"><input type="radio" name="sex" value="f" <: if $form.sex == 'f' { :> checked <: } :>> Жен</label>
                    </div>
                </div>
            </div>
            <div class="form-group <: if $fail.fio { :> has-error <: } :>">
                <label for="fio" class="col-sm-2 control-label">ФИО</label>
                <div class="col-sm-10"><input type="text" class="form-control" id="fio" placeholder="ФИО" name="fio" value="<: $form.fio :>"></div>
            </div>
            <div class="form-group <: if $fail.email { :> has-error <: } :>">
                <label for="email" class="col-sm-2 control-label">Email</label>
                <div class="col-sm-10"><input type="email" class="form-control" id="email" placeholder="Email" name="email" value="<: $form.email :>"></div>
                : if $fail.email_exist {
                    <span class="err">Такой E-mail уже существует</span>
                : }
            </div>
            <div class="form-group <: if $fail.password { :> has-error <: } :>">
                <label for="password" class="col-sm-2 control-label">Пароль</label>
                <div class="col-sm-10"><input type="password" class="form-control" id="password" placeholder="Пароль" name="password" value="<: $form.password :>"></div>
            </div>
            : if $role == 'student' {
                <div class="form-group <: if $fail.class_number { :> has-error <: } :>">
                    <label for="class_number" class="col-sm-2 control-label">Класс</label>
                    <div class="col-sm-10"><input type="number" class="form-control" id="class_number" placeholder="Класс" name="class_number" value="<: $form.class_number :>" min="1" max="11"></div>
                </div>
            : }
            : else if $role == 'teacher' {
                <div class="form-group <: if $fail.school_number { :> has-error <: } :>">
                    <label for="school_number" class="col-sm-2 control-label">Номер школы</label>
                    <div class="col-sm-10"><input type="text" class="form-control" id="school_number" placeholder="Номер школы" name="school_number" value="<: $form.school_number :>"></div>
                </div>
            : }

            <input type="text" name="code" placeholder="5+3" class="dnone" />

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10"><button type="submit" class="btn btn-default">Регистрация</button></div>
            </div>
        </form>
    </div>

: }
