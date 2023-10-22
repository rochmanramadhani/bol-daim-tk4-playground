<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Questions;
use App\Models\Quiz;
use App\Http\Requests\QuestionCreateRequest;
use App\Http\Requests\QuestionUpdateRequest;
use Illuminate\Support\Str;

class QuestionController extends Controller
{
    /**
     * Menampilkan daftar sumber daya.
     *
     * @return \Illuminate\Http\Response
     */
    public function index($id)
    {
        $quiz = Quiz::whereId($id)
            ->with('questions')
            ->first();
        return view('admin.question.list', compact('quiz'));
    }

    /**
     * Menampilkan formulir untuk membuat sumber daya baru.
     *
     * @return \Illuminate\Http\Response
     */
    public function create($id)
    {
        $quiz = Quiz::find($id);
        return view('admin.question.create', compact('quiz'));
    }

    /**
     * Menyimpan sumber daya yang baru dibuat ke dalam penyimpanan.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(QuestionCreateRequest $request, $id)
    {
        if ($request->hasFile('image')) {
            $fileName = Str::slug($request->question) . '.' . $request->image->extension();
            $fileNameWithUpload = 'uploads/' . $fileName;
            $request->image->move(public_path('uploads'), $fileName);
            $request->merge([
                'image' => $fileNameWithUpload,
            ]);
        }
        Quiz::find($id)
            ->questions()
            ->create($request->post());
        return redirect()
            ->route('questions.index', $id)
            ->withSuccess('Pertanyaan berhasil dibuat.');
    }

    /**
     * Menampilkan sumber daya yang ditentukan.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($quiz_id, $id)
    {
        return $quiz_id . ' - ' . $id;
    }

    /**
     * Menampilkan formulir untuk mengedit sumber daya yang ditentukan.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($quiz_id, $question_id)
    {
        $question =
            Quiz::find($quiz_id)
                ->questions()
                ->whereId($question_id)
                ->first() ?? abort(404, 'Quiz atau Pertanyaan Tidak Ditemukan');
        return view('admin.question.edit', compact('question'));
    }

    /**
     * Memperbarui sumber daya yang ditentukan di penyimpanan.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(QuestionUpdateRequest $request, $quiz_id, $question_id)
    {
        if ($request->hasFile('image')) {
            $fileName = Str::slug($request->question) . '.' . $request->image->extension();
            $fileNameWithUpload = 'uploads/' . $fileName;
            $request->image->move(public_path('uploads'), $fileName);
            $request->merge([
                'image' => $fileNameWithUpload,
            ]);
        }
        Quiz::find($quiz_id)
            ->questions()
            ->whereId($question_id)
            ->first()
            ->update($request->post());
        return redirect()
            ->route('questions.index', $quiz_id)
            ->withSuccess('Pertanyaan berhasil diperbarui.');
    }

    /**
     * Menghapus sumber daya yang ditentukan dari penyimpanan.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($quiz_id, $question_id)
    {
        Quiz::find($quiz_id)
            ->questions()
            ->whereId($question_id)
            ->delete();
        return redirect()
            ->route('questions.index', $quiz_id)
            ->withSuccess('Pertanyaan berhasil dihapus.');
    }
}
