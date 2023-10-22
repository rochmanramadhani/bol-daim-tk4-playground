<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class QuizCreateRequest extends FormRequest
{
    /**
     * Menentukan apakah pengguna memiliki izin untuk membuat permintaan ini.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Mendapatkan aturan validasi yang berlaku untuk permintaan ini.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'title' => 'required|min:3|max:200',
            'description' => 'max:1000',
            'finished_at' => 'nullable|after:' . now(),
        ];
    }

    public function attributes()
    {
        return [
            'title' => 'Judul Kuis',
            'description' => 'Deskripsi Kuis',
            'finished_at' => 'Tenggat Waktu Kuis',
        ];
    }
}
