create table migrations
(
    id        int unsigned auto_increment
        primary key,
    migration varchar(255) not null,
    batch     int          not null
);

create table password_resets
(
    email      varchar(255) not null,
    token      varchar(255) not null,
    created_at timestamp    null
);

create index password_resets_email_index
    on password_resets (email);

create table personal_access_tokens
(
    id             bigint unsigned auto_increment
        primary key,
    tokenable_type varchar(255)    not null,
    tokenable_id   bigint unsigned not null,
    name           varchar(255)    not null,
    token          varchar(64)     not null,
    abilities      text            null,
    last_used_at   timestamp       null,
    created_at     timestamp       null,
    updated_at     timestamp       null,
    constraint personal_access_tokens_token_unique
        unique (token)
);

create index personal_access_tokens_tokenable_type_tokenable_id_index
    on personal_access_tokens (tokenable_type, tokenable_id);

create table quizzes
(
    id          bigint unsigned auto_increment
        primary key,
    title       varchar(255)                                         not null,
    description longtext                                             null,
    slug        varchar(255)                                         not null,
    finished_at timestamp                                            null,
    status      enum ('publish', 'draft', 'selesai') default 'draft' not null,
    created_at  timestamp                                            null,
    updated_at  timestamp                                            null
);

create table questions
(
    id             bigint unsigned auto_increment
        primary key,
    quiz_id        bigint unsigned                                   not null,
    question       longtext                                          not null,
    image          longtext                                          null,
    answer1        longtext                                          not null,
    answer2        longtext                                          not null,
    answer3        longtext                                          not null,
    answer4        longtext                                          not null,
    correct_answer enum ('answer1', 'answer2', 'answer3', 'answer4') not null,
    created_at     timestamp                                         null,
    updated_at     timestamp                                         null,
    constraint questions_quiz_id_foreign
        foreign key (quiz_id) references quizzes (id)
            on delete cascade
);

create table sessions
(
    id            varchar(255)    not null
        primary key,
    user_id       bigint unsigned null,
    ip_address    varchar(45)     null,
    user_agent    text            null,
    payload       text            not null,
    last_activity int             not null
);

create index sessions_last_activity_index
    on sessions (last_activity);

create index sessions_user_id_index
    on sessions (user_id);

create table users
(
    id                        bigint unsigned auto_increment
        primary key,
    name                      varchar(255)                          not null,
    email                     varchar(255)                          not null,
    type                      enum ('admin', 'user') default 'user' not null,
    email_verified_at         timestamp                             null,
    password                  varchar(255)                          not null,
    two_factor_secret         text                                  null,
    two_factor_recovery_codes text                                  null,
    remember_token            varchar(100)                          null,
    current_team_id           bigint unsigned                       null,
    profile_photo_path        varchar(2048)                         null,
    created_at                timestamp                             null,
    updated_at                timestamp                             null,
    constraint users_email_unique
        unique (email)
);

create table answers
(
    id          bigint unsigned auto_increment
        primary key,
    user_id     bigint unsigned                                   not null,
    question_id bigint unsigned                                   not null,
    answer      enum ('answer1', 'answer2', 'answer3', 'answer4') not null,
    constraint answers_question_id_foreign
        foreign key (question_id) references questions (id)
            on delete cascade,
    constraint answers_user_id_foreign
        foreign key (user_id) references users (id)
            on delete cascade
);

create table results
(
    id         bigint unsigned auto_increment
        primary key,
    user_id    bigint unsigned not null,
    quiz_id    bigint unsigned not null,
    point      int             not null,
    correct    int             not null,
    wrong      int             not null,
    created_at timestamp       null,
    updated_at timestamp       null,
    constraint results_quiz_id_foreign
        foreign key (quiz_id) references quizzes (id)
            on delete cascade,
    constraint results_user_id_foreign
        foreign key (user_id) references users (id)
            on delete cascade
);

INSERT INTO u442207242_quiz.users (name, email, type, email_verified_at, password, two_factor_secret, two_factor_recovery_codes, remember_token, current_team_id, profile_photo_path, created_at, updated_at) VALUES ('Rochman', 'rochman@email.com', 'admin', '2023-10-22 08:11:12', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', null, null, null, null, null, null, null);

INSERT INTO u442207242_quiz.users (name, email, type, email_verified_at, password, two_factor_secret, two_factor_recovery_codes, remember_token, current_team_id, profile_photo_path, created_at, updated_at) VALUES ('Budi', 'budi@email.com', 'user', null, '$2y$10$4u5rSawU7cFDJcdnnzNRBehuwsKa7unhkPvSj5ECF6USGxp4hR5pu', null, null, null, null, null, '2023-10-22 10:17:37', '2023-10-22 10:17:37');

INSERT INTO u442207242_quiz.users (name, email, type, email_verified_at, password, two_factor_secret, two_factor_recovery_codes, remember_token, current_team_id, profile_photo_path, created_at, updated_at) VALUES ('Try Wulan', 'trywulan@email.com', 'user', '2023-10-22 08:11:12', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', null, null, null, null, null, null, null);

INSERT INTO u442207242_quiz.users (name, email, type, email_verified_at, password, two_factor_secret, two_factor_recovery_codes, remember_token, current_team_id, profile_photo_path, created_at, updated_at) VALUES ('Vallen', 'vallen@email.com', 'user', null, '$2y$10$4u5rSawU7cFDJcdnnzNRBehuwsKa7unhkPvSj5ECF6USGxp4hR5pu', null, null, null, null, null, '2023-10-22 10:17:37', '2023-10-22 10:17:37');

INSERT INTO u442207242_quiz.users (name, email, type, email_verified_at, password, two_factor_secret, two_factor_recovery_codes, remember_token, current_team_id, profile_photo_path, created_at, updated_at) VALUES ('Kirey', 'kirey@email.com', 'user', null, '$2y$10$4u5rSawU7cFDJcdnnzNRBehuwsKa7unhkPvSj5ECF6USGxp4hR5pu', null, null, null, null, null, '2023-10-22 10:17:37', '2023-10-22 10:17:37');

INSERT INTO u442207242_quiz.users (name, email, type, email_verified_at, password, two_factor_secret, two_factor_recovery_codes, remember_token, current_team_id, profile_photo_path, created_at, updated_at) VALUES ('Farhan', 'farhan@email.com', 'user', null, '$2y$10$4u5rSawU7cFDJcdnnzNRBehuwsKa7unhkPvSj5ECF6USGxp4hR5pu', null, null, null, null, null, '2023-10-22 10:17:37', '2023-10-22 10:17:37');

INSERT INTO u442207242_quiz.users (name, email, type, email_verified_at, password, two_factor_secret, two_factor_recovery_codes, remember_token, current_team_id, profile_photo_path, created_at, updated_at) VALUES ('Ismail', 'ismail@email.com', 'user', null, '$2y$10$4u5rSawU7cFDJcdnnzNRBehuwsKa7unhkPvSj5ECF6USGxp4hR5pu', null, null, null, null, null, '2023-10-22 10:17:37', '2023-10-22 10:17:37');

INSERT INTO u442207242_quiz.users (name, email, type, email_verified_at, password, two_factor_secret, two_factor_recovery_codes, remember_token, current_team_id, profile_photo_path, created_at, updated_at) VALUES ('Ayaya', 'ayaya@email.com', 'user', null, '$2y$10$4u5rSawU7cFDJcdnnzNRBehuwsKa7unhkPvSj5ECF6USGxp4hR5pu', null, null, null, null, null, '2023-10-22 10:17:37', '2023-10-22 10:17:37');

INSERT INTO u442207242_quiz.users (name, email, type, email_verified_at, password, two_factor_secret, two_factor_recovery_codes, remember_token, current_team_id, profile_photo_path, created_at, updated_at) VALUES ('Rydwan', 'rydwan@email.com', 'user', null, '$2y$10$4u5rSawU7cFDJcdnnzNRBehuwsKa7unhkPvSj5ECF6USGxp4hR5pu', null, null, null, null, null, '2023-10-22 10:17:37', '2023-10-22 10:17:37');

INSERT INTO u442207242_quiz.users (name, email, type, email_verified_at, password, two_factor_secret, two_factor_recovery_codes, remember_token, current_team_id, profile_photo_path, created_at, updated_at) VALUES ('Agus', 'agus@email.com', 'user', null, '$2y$10$4OuivlpnvbfpgAlKMsxme.tLW6ekKUCpG9zC7Xwy6ZBMDAhnk6byu', null, null, null, null, null, '2023-10-22 12:05:10', '2023-10-22 12:05:10');

INSERT INTO u442207242_quiz.quizzes (title, description, slug, finished_at, status, created_at, updated_at) VALUES ('Sistem Informasi Manajemen', 'Quiz ini menguji pengetahuan Anda tentang konsep dasar dalam Sistem Informasi Manajemen.', 'sistem-informasi-manajemen', null, 'publish', '2023-10-22 10:27:36', '2023-10-22 10:42:53');

INSERT INTO u442207242_quiz.quizzes (title, description, slug, status, finished_at, created_at, updated_at) VALUES ('Laravel Framework', 'Quiz ini akan menguji pengetahuan Anda tentang Laravel, salah satu kerangka kerja (framework) PHP yang populer.', 'laravel-framework', null, 'publish', '2023-10-22 17:27:36', '2023-10-22 17:42:53');

INSERT INTO u442207242_quiz.quizzes (title, description, slug, status, finished_at, created_at, updated_at) VALUES ('Dasar Pemrograman', 'Quiz ini akan menguji pengetahuan Anda tentang konsep dasar dalam pemrograman.', 'dasar-pemrograman', null, 'publish', '2023-10-22 17:27:36', '2023-10-22 17:42:53');

INSERT INTO u442207242_quiz.quizzes (title, description, slug, status, finished_at, created_at, updated_at) VALUES ('Dasar-dasar JavaScript', 'Quiz ini akan menguji pengetahuan Anda tentang dasar-dasar pemrograman dengan JavaScript.', 'dasar-dasar-javascript', null, 'publish', '2023-10-22 17:27:36', '2023-10-22 17:42:53');

INSERT INTO u442207242_quiz.quizzes (title, description, slug, status, finished_at, created_at, updated_at) VALUES ('Pengenalan Database', 'Quiz ini akan menguji pengetahuan Anda tentang dasar-dasar database dan manajemen data.', 'pengenalan-database', 'publish', null, '2023-10-22 10:27:36', '2023-10-22 10:42:53');

INSERT INTO u442207242_quiz.quizzes (title, description, slug, status, finished_at, created_at, updated_at) VALUES ('Pengetahuan Umum', 'Quiz ini akan menguji pengetahuan Anda tentang berbagai topik pengetahuan umum.', 'pengetahuan-umum', 'publish', null, '2023-10-22 10:27:36', '2023-10-22 10:42:53');

INSERT INTO u442207242_quiz.quizzes (title, description, slug, status, finished_at, created_at, updated_at) VALUES ('Wawasan Nusantara Indonesia', 'Quiz ini akan menguji pengetahuan Anda tentang berbagai aspek Nusantara Indonesia, termasuk budaya, geografi, sejarah, dan lainnya.', 'wawasan-nusantara-indonesia', 'publish', null,'2023-10-22 10:27:36', '2023-10-22 10:42:53');

INSERT INTO u442207242_quiz.questions (quiz_id, question, image, answer1, answer2, answer3, answer4, correct_answer, created_at, updated_at) VALUES (1, 'Apa itu Sistem Informasi Manajemen (SIM)?', 'uploads/apa-itu-sistem-informasi-manajemen-sim.jpg', 'Sebuah alat untuk membuat laporan keuangan.', 'Sistem yang mengelola informasi dalam organisasi.', 'Sebuah metode untuk mengelola proyek IT.', 'Sebuah jenis komputer yang digunakan untuk menghitung data.', 'answer2', '2023-10-22 10:28:53', '2023-10-22 10:28:53');

INSERT INTO u442207242_quiz.questions (quiz_id, question, image, answer1, answer2, answer3, answer4, correct_answer, created_at, updated_at) VALUES (1, 'Apa peran utama SIM dalam sebuah organisasi?', null, 'Memeriksa kualitas produk.', 'Membantu dalam manajemen SDM.', 'Mengelola informasi untuk pengambilan keputusan.', 'Menyimpan persediaan perusahaan.', 'answer3', '2023-10-22 10:34:26', '2023-10-22 10:34:26');

INSERT INTO u442207242_quiz.questions (quiz_id, question, image, answer1, answer2, answer3, answer4, correct_answer, created_at, updated_at) VALUES (1, 'Apa yang dimaksud dengan "Input" dalam SIM?', null, 'Perangkat keras komputer.', 'Data yang dimasukkan ke dalam sistem.', 'Hasil keluaran sistem.', 'Peralatan kantor.', 'answer2', '2023-10-22 10:38:17', '2023-10-22 10:38:17');

INSERT INTO u442207242_quiz.questions (quiz_id, question, image, answer1, answer2, answer3, answer4, correct_answer, created_at, updated_at) VALUES (1, 'Apa yang dimaksud dengan "Output" dalam SIM?', null, 'Perangkat keras komputer.', 'Data yang dimasukkan ke dalam sistem.', 'Hasil keluaran sistem.', 'Peralatan kantor.', 'answer3', '2023-10-22 10:38:55', '2023-10-22 10:38:55');

INSERT INTO u442207242_quiz.questions (quiz_id, question, image, answer1, answer2, answer3, answer4, correct_answer, created_at, updated_at) VALUES (1, 'Bagaimana SIM membantu manajemen dalam pengambilan keputusan?', null, 'Dengan menyediakan makanan untuk karyawan.', 'Dengan memberikan gaji kepada karyawan.', 'Dengan memberikan hiburan di tempat kerja.', 'Dengan menyediakan informasi yang relevan dan akurat.', 'answer4', '2023-10-22 10:39:35', '2023-10-22 10:39:35');

INSERT INTO u442207242_quiz.questions (quiz_id, question, image, answer1, answer2, answer3, answer4, correct_answer, created_at, updated_at) VALUES (1, 'Apa yang dimaksud dengan "Database" dalam konteks SIM?', null, 'Sebuah kantor yang menyimpan dokumen.', 'Sebuah kumpulan alat tulis.', 'Sebuah sistem yang digunakan untuk mengelola dan menyimpan data.', 'Sebuah jenis komputer.', 'answer3', '2023-10-22 17:40:15', '2023-10-22 17:40:15');

INSERT INTO u442207242_quiz.questions (quiz_id, question, image, answer1, answer2, answer3, answer4, correct_answer, created_at, updated_at) VALUES (1, 'Apa yang dimaksud dengan "E-commerce" dalam SIM?', null, 'Sistem yang mengelola informasi kucing.', 'Penjualan barang dan jasa secara online.', 'Pengelolaan restoran.', 'Kegiatan olahraga ekstrem.', 'answer2', '2023-10-22 17:40:52', '2023-10-22 17:40:52');

INSERT INTO u442207242_quiz.questions (quiz_id, question, image, answer1, answer2, answer3, answer4, correct_answer, created_at, updated_at) VALUES (1, 'Apa yang dimaksud dengan "Sistem Pendukung Keputusan" (SPK) dalam SIM?', null, 'Sebuah sistem untuk membuat keputusan tanpa bantuan.', 'Sebuah sistem yang memberikan saran untuk pengambilan keputusan.', 'Sebuah sistem untuk mengirim pesan.', 'Sebuah jenis komputer.', 'answer2', '2023-10-22 17:41:27', '2023-10-22 17:41:27');

INSERT INTO u442207242_quiz.questions (quiz_id, question, image, answer1, answer2, answer3, answer4, correct_answer, created_at, updated_at) VALUES (1, 'Apa yang dimaksud dengan "Cloud Computing" dalam SIM?', null, 'Sebuah teknik memasak berdasarkan ramalan cuaca.', 'Sebuah sistem penyimpanan data di internet.', 'Sebuah metode transportasi menggunakan awan.', 'Sebuah jenis komputer.', 'answer2', '2023-10-22 17:41:58', '2023-10-22 17:41:58');

INSERT INTO u442207242_quiz.questions (quiz_id, question, image, answer1, answer2, answer3, answer4, correct_answer, created_at, updated_at) VALUES (1, 'Apa yang dimaksud dengan "ERP" dalam SIM?', null, 'Sebuah jenis peralatan restoran.', 'Sebuah metode pengembangan perangkat lunak.', 'Sebuah sistem yang mengelola produksi pakaian.', 'Sebuah sistem yang mengintegrasikan berbagai proses bisnis dalam satu aplikasi.', 'answer4', '2023-10-22 17:42:28', '2023-10-22 17:42:28');

INSERT INTO u442207242_quiz.questions (quiz_id, question, image, answer1, answer2, answer3, answer4, correct_answer, created_at, updated_at) VALUES (2, 'Apa itu Laravel?', null, 'Sebuah kerangka kerja PHP', 'Sebuah bahasa pemrograman', 'Sebuah jenis database', 'Sebuah alat untuk menggambar', 'answer1', '2023-10-22 17:28:53', '2023-10-22 17:28:53');

INSERT INTO u442207242_quiz.questions (quiz_id, question, image, answer1, answer2, answer3, answer4, correct_answer, created_at, updated_at) VALUES (2, 'Siapa pencipta Laravel?', null, 'Taylor Otwell', 'Mark Zuckerberg', 'Jeff Bezos', 'Sundar Pichai', 'answer1', '2023-10-22 17:34:26', '2023-10-22 17:34:26');

INSERT INTO u442207242_quiz.questions (quiz_id, question, image, answer1, answer2, answer3, answer4, correct_answer, created_at, updated_at) VALUES (2, 'Apa yang dimaksud dengan "Eloquent" dalam Laravel?', null, 'Sebuah kelas PHP untuk berinteraksi dengan database', 'Sebuah bahasa pemrograman', 'Sebuah jenis template', 'Sebuah jenis server web', 'answer1', '2023-10-22 17:38:17', '2023-10-22 17:38:17');

INSERT INTO u442207242_quiz.questions (quiz_id, question, image, answer1, answer2, answer3, answer4, correct_answer, created_at, updated_at) VALUES (2, 'Apakah "MVC" dalam konteks Laravel?', null, 'Model-View-Controller', 'Media Video Converter', 'My Very Cool', 'Mobile View Creator', 'answer1', '2023-10-22 17:38:55', '2023-10-22 17:38:55');

INSERT INTO u442207242_quiz.questions (quiz_id, question, image, answer1, answer2, answer3, answer4, correct_answer, created_at, updated_at) VALUES (2, 'Bagaimana cara membuat rute (route) dalam Laravel?', null, 'Dalam file web.php', 'Dalam file HTML', 'Dalam file CSS', 'Dalam file JavaScript', 'answer1', '2023-10-22 17:39:35', '2023-10-22 17:39:35');

INSERT INTO u442207242_quiz.questions (quiz_id, question, image, answer1, answer2, answer3, answer4, correct_answer, created_at, updated_at) VALUES (3, 'Apa itu pemrograman?', null, 'Sebuah proses mengolah data', 'Sebuah jenis makanan', 'Sebuah bahasa manusia', 'Sebuah mesin fotokopi', 'answer1', '2023-10-22 17:28:53', '2023-10-22 17:28:53');

INSERT INTO u442207242_quiz.questions (quiz_id, question, image, answer1, answer2, answer3, answer4, correct_answer, created_at, updated_at) VALUES (3, 'Apa yang dimaksud dengan algoritma?', null, 'Sebuah langkah-langkah untuk menyelesaikan masalah', 'Sebuah alat musik', 'Sebuah jenis kendaraan', 'Sebuah jenis hewan', 'answer1', '2023-10-22 17:34:26', '2023-10-22 17:34:26');

INSERT INTO u442207242_quiz.questions (quiz_id, question, image, answer1, answer2, answer3, answer4, correct_answer, created_at, updated_at) VALUES (3, 'Apa yang dimaksud dengan variabel dalam pemrograman?', null, 'Sebuah wadah untuk menyimpan data', 'Sebuah alat untuk memasak', 'Sebuah jenis bunga', 'Sebuah jenis kapal', 'answer1', '2023-10-22 17:38:17', '2023-10-22 17:38:17');

INSERT INTO u442207242_quiz.questions (quiz_id, question, image, answer1, answer2, answer3, answer4, correct_answer, created_at, updated_at) VALUES (3, 'Apa peran dari pernyataan "if" dalam pemrograman?', null, 'Untuk mengatur aliran eksekusi program', 'Untuk membuat kopi', 'Untuk menggambar gambar', 'Untuk berbicara kepada pengguna', 'answer1', '2023-10-22 17:38:55', '2023-10-22 17:38:55');

INSERT INTO u442207242_quiz.questions (quiz_id, question, image, answer1, answer2, answer3, answer4, correct_answer, created_at, updated_at) VALUES (3, 'Apa yang dimaksud dengan "loop" dalam pemrograman?', null, 'Sebuah perulangan instruksi', 'Sebuah jenis hewan', 'Sebuah jenis makanan', 'Sebuah alat musik', 'answer1', '2023-10-22 17:39:35', '2023-10-22 17:39:35');

INSERT INTO u442207242_quiz.questions (quiz_id, question, image, answer1, answer2, answer3, answer4, correct_answer, created_at, updated_at) VALUES (4, 'Apa itu JavaScript?', null, 'Bahasa pemrograman untuk pengembangan web', 'Sebuah jenis makanan', 'Sebuah bahasa manusia', 'Sebuah jenis mobil', 'answer1', '2023-10-22 17:28:53', '2023-10-22 17:28:53');

INSERT INTO u442207242_quiz.questions (quiz_id, question, image, answer1, answer2, answer3, answer4, correct_answer, created_at, updated_at) VALUES (4, 'Apa yang dimaksud dengan variabel dalam JavaScript?', null, 'Sebuah wadah untuk menyimpan data', 'Sebuah jenis alat musik', 'Sebuah jenis bunga', 'Sebuah jenis kapal', 'answer1', '2023-10-22 17:34:26', '2023-10-22 17:34:26');

INSERT INTO u442207242_quiz.questions (quiz_id, question, image, answer1, answer2, answer3, answer4, correct_answer, created_at, updated_at) VALUES (4, 'Apa itu sintaksis JavaScript?', null, 'Aturan tata bahasa dalam penulisan kode', 'Sebuah jenis hewan', 'Sebuah jenis makanan', 'Sebuah alat musik', 'answer1', '2023-10-22 17:38:17', '2023-10-22 17:38:17');

INSERT INTO u442207242_quiz.questions (quiz_id, question, image, answer1, answer2, answer3, answer4, correct_answer, created_at, updated_at) VALUES (4, 'Apa yang dimaksud dengan "fungsi" dalam JavaScript?', null, 'Sebuah blok kode yang dapat dipanggil', 'Sebuah jenis kendaraan', 'Sebuah jenis hewan', 'Sebuah jenis makanan', 'answer1', '2023-10-22 17:38:55', '2023-10-22 17:38:55');

INSERT INTO u442207242_quiz.questions (quiz_id, question, image, answer1, answer2, answer3, answer4, correct_answer, created_at, updated_at) VALUES (4, 'Apa peran dari pernyataan "if" dalam JavaScript?', null, 'Untuk mengatur aliran eksekusi kode', 'Untuk membuat kopi', 'Untuk menggambar gambar', 'Untuk berbicara kepada pengguna', 'answer1', '2023-10-22 17:39:35', '2023-10-22 17:39:35');

INSERT INTO u442207242_quiz.questions (quiz_id, question, answer1, answer2, answer3, answer4, correct_answer, created_at, updated_at) VALUES (5, 'Apa yang dimaksud dengan database?', 'Tempat penyimpanan data elektronik', 'Sebuah jenis alat musik', 'Sebuah jenis makanan', 'Sebuah jenis kendaraan', 'answer1', '2023-10-22 10:28:53', '2023-10-22 10:28:53');

INSERT INTO u442207242_quiz.questions (quiz_id, question, answer1, answer2, answer3, answer4, correct_answer, created_at, updated_at) VALUES (5, 'Apa peran utama database dalam pengembangan aplikasi?', 'Menyimpan dan mengelola data', 'Mengambil gambar', 'Menghitung uang', 'Menggambar grafik', 'answer1', '2023-10-22 10:34:26', '2023-10-22 10:34:26');

INSERT INTO u442207242_quiz.questions (quiz_id, question, answer1, answer2, answer3, answer4, correct_answer, created_at, updated_at) VALUES (5, 'Apa yang dimaksud dengan SQL (Structured Query Language)?', 'Bahasa untuk berinteraksi dengan database', 'Sebuah jenis hewan', 'Sebuah jenis makanan', 'Sebuah alat musik', 'answer1', '2023-10-22 10:38:17', '2023-10-22 10:38:17');

INSERT INTO u442207242_quiz.questions (quiz_id, question, answer1, answer2, answer3, answer4, correct_answer, created_at, updated_at) VALUES (5, 'Apa yang dimaksud dengan tabel dalam database?', 'Struktur data yang terdiri dari baris dan kolom', 'Sebuah jenis kendaraan', 'Sebuah jenis hewan', 'Sebuah jenis makanan', 'answer1', '2023-10-22 10:38:55', '2023-10-22 10:38:55');

INSERT INTO u442207242_quiz.questions (quiz_id, question, answer1, answer2, answer3, answer4, correct_answer, created_at, updated_at) VALUES (5, 'Apa perbedaan antara database SQL dan NoSQL?', 'Metode penyimpanan dan pengambilan data', 'Warna dan bentuk', 'Rasa dan aroma', 'Ukuran dan berat', 'answer1', '2023-10-22 10:39:35', '2023-10-22 10:39:35');

INSERT INTO u442207242_quiz.questions (quiz_id, question, answer1, answer2, answer3, answer4, correct_answer, created_at, updated_at) VALUES (6, 'Siapakah penemu lampu pijar?', 'Thomas Edison', 'Albert Einstein', 'Galileo Galilei', 'Alexander Graham Bell', 'answer1', '2023-10-22 10:28:53', '2023-10-22 10:28:53');

INSERT INTO u442207242_quiz.questions (quiz_id, question, answer1, answer2, answer3, answer4, correct_answer, created_at, updated_at) VALUES (6, 'Ibukota negara Jepang adalah...', 'Tokyo', 'Beijing', 'Seoul', 'Bangkok', 'answer1', '2023-10-22 10:34:26', '2023-10-22 10:34:26');

INSERT INTO u442207242_quiz.questions (quiz_id, question, answer1, answer2, answer3, answer4, correct_answer, created_at, updated_at) VALUES (6, 'Siapakah pelukis terkenal yang menciptakan "Mona Lisa"?', 'Leonardo da Vinci', 'Pablo Picasso', 'Vincent van Gogh', 'Rembrandt', 'answer1', '2023-10-22 10:38:17', '2023-10-22 10:38:17');

INSERT INTO u442207242_quiz.questions (quiz_id, question, answer1, answer2, answer3, answer4, correct_answer, created_at, updated_at) VALUES (6, 'Berapakah jumlah planet dalam tata surya kita?', '8', '7', '9', '6', 'answer1', '2023-10-22 10:38:55', '2023-10-22 10:38:55');

INSERT INTO u442207242_quiz.questions (quiz_id, question, answer1, answer2, answer3, answer4, correct_answer, created_at, updated_at) VALUES (6, 'Siapakah penulis novel "Harry Potter"?', 'J.K. Rowling', 'George Orwell', 'William Shakespeare', 'Charles Dickens', 'answer1', '2023-10-22 10:39:35', '2023-10-22 10:39:35');

INSERT INTO u442207242_quiz.questions (quiz_id, question, answer1, answer2, answer3, answer4, correct_answer, created_at, updated_at) VALUES (7, 'Ibukota Indonesia adalah...', 'Jakarta', 'Bandung', 'Surabaya', 'Medan', 'answer1', '2023-10-22 10:28:53', '2023-10-22 10:28:53');

INSERT INTO u442207242_quiz.questions (quiz_id, question, answer1, answer2, answer3, answer4, correct_answer, created_at, updated_at) VALUES (7, 'Apa nama pulau terbesar di Indonesia?', 'Kalimantan', 'Jawa', 'Sumatera', 'Sulawesi', 'answer2', '2023-10-22 10:34:26', '2023-10-22 10:34:26');

INSERT INTO u442207242_quiz.questions (quiz_id, question, answer1, answer2, answer3, answer4, correct_answer, created_at, updated_at) VALUES (7, 'Siapa proklamator Kemerdekaan Indonesia?', 'Soekarno', 'Soeharto', 'Megawati', 'Jokowi', 'answer1', '2023-10-22 10:38:17', '2023-10-22 10:38:17');

INSERT INTO u442207242_quiz.questions (quiz_id, question, answer1, answer2, answer3, answer4, correct_answer, created_at, updated_at) VALUES (7, 'Apa julukan Indonesia yang merujuk pada keragaman etnis dan budayanya?', 'Negara Seribu Pulau', 'Bumi Pertiwi', 'Tanah Air Kita', 'NKRI', 'answer3', '2023-10-22 10:38:55', '2023-10-22 10:38:55');

INSERT INTO u442207242_quiz.questions (quiz_id, question, answer1, answer2, answer3, answer4, correct_answer, created_at, updated_at) VALUES (7, 'Pulau terbesar kedua di Indonesia adalah...', 'Sulawesi', 'Kalimantan', 'Jawa', 'Sumatera', 'answer2', '2023-10-22 10:39:35', '2023-10-22 10:39:35');
