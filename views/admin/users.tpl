: cascade layouts::admin
: around content -> {

    <div class="row">
    : if $list {
        <div class="col-md-12">
            <ul class="nav nav-pills">
                <li <: if $role == 'student' { :> class="active" <: } :>><a href="/admin/users/?role=student">Ученики</a></li>
                <li <: if $role == 'teacher' { :> class="active" <: } :>><a href="/admin/users/?role=teacher">Учителя</a></li>
                <li <: if $role == 'parent' { :> class="active" <: } :>><a href="/admin/users/?role=parent">Родители</a></li>
                <li <: if $role == 'admin' { :> class="active" <: } :>><a href="/admin/users/?role=admin">Админы</a></li>
            </ul>
        </div>

        <div class="col-md-12">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>ФИО</th>
                        <th>E-mail</th>
                        <th>&nbsp;</th>
                    </tr>
                </thead>
                <tbody>
                    : for $list -> $el {
                        <tr>
                            <td><: $~el.count :></td>
                            <td><: $el.fio :></td>
                            <td><: $el.email :></td>
                            <td class="js_edit_item" data-link="/admin/users/<: $el.id :>"></td>
                        </tr>
                    : }
                </tbody>
            </table>
        </div>
    : }
    : else {
        <form class="form-horizontal" method="post" action="" enctype="multipart/form-data">
            <div class="form-group">
                <label class="control-label">Время регистрации</label>
                <div><: $form.registered :></div>
            </div>
            <div class="form-group">
                <label class="control-label">E-mail</label>
                <div><: $form.email :></div>
            </div>
            <div class="form-group <: if $fail.fio { :> has-error <: } :>">
                <label class="control-label" for="fio">ФИО</label>
                <div><input type="text" id="fio" name="fio" value="<: $form.fio :>" placeholder="ФИО" class="form-control"></div>
            </div>
        </form>
    : }
    </div>

    : if 0 {
        [% BLOCK submit_buttons %]
            <div class="control-group">
                <div class="controls">
                  <button type="submit" class="btn btn-primary">Сохранить</button>
                  <a href="/admin/users/" class="btn">Отмена</a>
                </div>
            </div>
                [% IF action == "edit" %]
                    <button class="btn btn-primary" type="submit" name="action" value="update">Сохранить</button>
                    <button class="btn btn-default" type="submit" name="action" value="cancel">Отмена</button>
                [% ELSE %]
                    <button class="btn btn-primary" type="submit" name="action" value="create">Добавить</button>
                [% END %]
        [% END %]
    : }
: }
