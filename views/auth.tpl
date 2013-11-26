<form action="/auth/register/" method="post">
    <fieldset>
        <h3>Регистрация</h3>
            <label class="label">E-mail:</label>
            <input type="text" name="email" value="[% form.email %]" [% 'class="red"' IF err.email %] />

            <label class="label">ФИО:</label>
            <input type="text" name="fio" value="[% form.fio %]" [% 'class="red"' IF err.fio %] />

            <label class="label">Пароль:</label>
            <input type="text" name="password" value="[% form.password %]" [% 'class="red"' IF err.password %] />

            <!--li>
                [% '<span class="err">Такой E-mail уже существует</span>' IF err.email_exist %]
            </li-->

            <input type="text" name="code" placeholder="5+3" class="dnone" />

            <input value="Зарегистрироваться" type="submit" />
    </fieldset>
</form>
