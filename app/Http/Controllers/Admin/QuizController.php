<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Quiz;
use App\Http\Requests\QuizCreateRequest;
use App\Http\Requests\QuizUpdateRequest;

class QuizController extends Controller
{
    /**
     * Menampilkan daftar sumber daya.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $quizzes = Quiz::withCount('questions');
        if (request()->get('title')) {
            $quizzes = $quizzes->where('title', 'LIKE', '%' . request()->get('title') . '%');
        }
        if (request()->get('status')) {
            $quizzes = $quizzes->where('status', request()->get('status'));
        }
        $quizzes = $quizzes->paginate(5);

        return view('admin.quiz.list', compact('quizzes'));
    }

    /**
     * Menampilkan formulir untuk membuat sumber daya baru.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('admin.quiz.create');
    }

    /**
     * Menyimpan sumber daya yang baru dibuat ke dalam penyimpanan.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(QuizCreateRequest $request)
    {
        Quiz::create($request->post());
        return redirect()
            ->route('quizzes.index')
            ->withSuccess('Quiz berhasil dibuat.');
    }

    /**
     * Menampilkan sumber daya yang ditentukan.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $quiz =
            Quiz::with('topTen.user')
                ->withCount('questions')
                ->find($id) ?? abort(404, 'Quiz Tidak Ditemukan');

        return view('admin.quiz.show', compact('quiz'));
    }

    /**
     * Menampilkan formulir untuk mengedit sumber daya yang ditentukan.
     *
     * @param  int  $id
     * @return \Illuminate\Http.Response
     */
    public function edit($id)
    {
        $quiz = Quiz::withCount('questions')->find($id) ?? abort(404, 'Quiz Tidak Ditemukan');
        return view('admin.quiz.edit', compact('quiz'));
    }

    /**
     * Memperbarui sumber daya yang ditentukan di penyimpanan.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(QuizUpdateRequest $request, $id)
    {
        $quiz = Quiz::find($id) ?? abort(404, 'Quiz Tidak Ditemukan');
        Quiz::find($id)->update($request->except(['_method', '_token']));

        return redirect()
            ->route('quizzes.index')
            ->withSuccess('Pembaruan quiz berhasil dilakukan.');
    }

    /**
     * Menghapus sumber daya yang ditentukan dari penyimpanan.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $quiz = Quiz::find($id) ?? abort(404, 'Quiz Tidak Ditemukan');
        $quiz->delete();
        return redirect()
            ->route('quizzes.index')
            ->withSuccess('Penghapusan quiz berhasil dilakukan!');
    }
}
