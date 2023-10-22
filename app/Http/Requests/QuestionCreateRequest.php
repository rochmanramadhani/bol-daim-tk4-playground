<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class QuestionCreateRequest extends FormRequest
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
            'question' => 'required|min:3',
            'image' => 'image|nullable|max:1024|mimes:jpg,jpeg,png',
            'answer1' => 'required|min:1',
            'answer2' => 'required|min:1',
            'answer3' => 'required|min:1',
            'answer4' => 'required|min:1',
            'correct_answer' => 'required',
        ];
    }

    public function attributes()
    {
        return [
            'question' => 'Pertanyaan',
            'image' => 'Foto Pertanyaan',
            'answer1' => 'Jawaban 1',
            'answer2' => 'Jawaban 2',
            'answer3' => 'Jawaban 3',
            'answer4' => 'Jawaban 4',
            'correct_answer' => 'Jawaban Benar',
        ];
    }
}
