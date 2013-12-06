: cascade layouts::main
: around content -> {

    <div class="col-md-5">
        <h2>Профиль</h2>
        <form class="form-horizontal" role="form" method="post" action="/user/profile/">
        <input type="hidden" name="role" value="<: $role :>">
            <div class="form-group">
                <label for="sex" class="col-sm-2 control-label">Пол</label>
                <div class="col-sm-10">
                    : if $vars.loged.sex == 'm' {
                        Мужской
                    :}
                    : else {
                        Женский
                    :}
                </div>
            </div>
            <div class="form-group <: if $fail.email { :> has-error <: } :>">
                <label for="email" class="col-sm-2 control-label">Логин</label>
                <div class="col-sm-10"><input type="email" class="form-control" id="email" placeholder="Email" name="email" value="<: $vars.loged.email :>" disabled></div>
            </div>
            <div class="form-group <: if $fail.fio { :> has-error <: } :>">
                <label for="fio" class="col-sm-2 control-label">ФИО</label>
                <div class="col-sm-10"><input type="text" class="form-control" id="fio" placeholder="ФИО" name="fio" value="<: $vars.loged.fio :>"></div>
            </div>
            <div class="form-group <: if $fail.password { :> has-error <: } :>">
                <label for="password" class="col-sm-2 control-label">Пароль</label>
                <div class="col-sm-10"><input type="password" class="form-control" id="password" placeholder="Пароль" name="password" value=""></div>
            </div>
            : if $vars.loged.role == 'student' {
                <div class="form-group <: if $fail.class_number { :> has-error <: } :>">
                    <label for="class_number" class="col-sm-2 control-label">Класс</label>
                    <div class="col-sm-10"><input type="number" class="form-control" id="class_number" placeholder="Класс" name="class_number" value="<: $vars.loged.class_number :>" min="1" max="11"></div>
                </div>
            : }
            : else if $vars.loged.role == 'teacher' {
                <div class="form-group <: if $fail.school_number { :> has-error <: } :>">
                    <label for="school_number" class="col-sm-2 control-label">Номер школы</label>
                    <div class="col-sm-10"><input type="text" class="form-control" id="school_number" placeholder="Номер школы" name="school_number" value="<: $vars.loged.school_number :>"></div>
                </div>
            : }

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10"><button type="submit" class="btn btn-default">Обновить</button></div>
            </div>
        </form>
    </div>

: }
