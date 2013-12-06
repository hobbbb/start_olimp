: cascade layouts::main
: around content -> {

    <div class="col-md-5">
        <h2>Восстановление пароля</h2>
        <form class="form-horizontal" role="form" method="post" action="/auth/restore/">
            <div class="form-group <: if $fail.email { :> has-error <: } :>">
                <label for="email" class="col-sm-2 control-label">Email</label>
                <div class="col-sm-10"><input type="email" class="form-control" id="email" placeholder="Email" name="email" value="<: $form.email :>"></div>
                : if $fail.email_exist {
                    <span class="err">Такой E-mail уже существует</span>
                : }
            </div>

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10"><button type="submit" class="btn btn-default">Выслать на почту</button></div>
            </div>
        </form>
    </div>

: }
