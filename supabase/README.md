# Supabase для каталогу «Наші двері»

1. Увійдіть на [Supabase](https://supabase.com/dashboard) і натисніть **New project**.
2. Назва: `nashi-dveri`; регіон — найближчий європейський; пароль бази збережіть у надійному місці.
3. Після створення відкрийте **SQL Editor** → **New query**, скопіюйте вміст `schema.sql` і натисніть **Run**.
4. У **Project Settings → API** скопіюйте `Project URL` та `Publishable key` (або `anon` key).
5. Додайте їх у Vercel: **Project → Settings → Environment Variables**. Назви змінних наведені в `.env.example`.

Не передавайте і не додавайте в GitHub `service_role` key або пароль бази даних. Для сайту використовується лише публічний ключ.

Після цього наступним кроком перенесемо 363 моделі та їхні фото в `catalog-images`, а сайт почне брати каталог із Supabase.
