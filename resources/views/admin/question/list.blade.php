<x-app-layout>
    <x-slot name="header">Soal-soal untuk Quiz {{ $quiz->title }}</x-slot>
    <div class="card">
        <div class="card-body">
            <h5 class="card-title float-start">
                <a href="{{ route('quizzes.index') }}" class="btn btn-sm btn-secondary"><i class="fa fa-arrow-left"></i> Kembali ke Daftar Quiz</a>
            </h5>
            <h5 class="card-title float-end">
                <a href="{{ route('questions.create', $quiz->id) }}" class="btn btn-sm btn-primary"><i class="fa fa-plus"></i> Tambah Soal</a>
            </h5>
            <table class="table table-bordered table-sm">
                <thead>
                    <tr>
                        <th scope="col">Pertanyaan</th>
                        <th scope="col">Gambar</th>
                        <th scope="col">Jawaban 1</th>
                        <th scope="col">Jawaban 2</th>
                        <th scope="col">Jawaban 3</th>
                        <th scope="col">Jawaban 4</th>
                        <th scope="col">Jawaban Benar</th>
                        <th scope="col" style="width:90px">Tindakan</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($quiz->questions as $question)
                        <tr>
                            <td>{{ $question->question }}</td>
                            <td>
                                @if ($question->image)
                                    <a href="{{ asset($question->image) }}" class="btn btn-sm btn-light" target="_blank">Tampilkan</a>
                                @endif
                            </td>
                            <td>{{ $question->answer1 }}</td>
                            <td>{{ $question->answer2 }}</td>
                            <td>{{ $question->answer3 }}</td>
                            <td>{{ $question->answer4 }}</td>
                            <td class="text-success">{{ substr($question->correct_answer, -1) }}. Jawaban</td>
                            <td>
                                <a href="{{ route('questions.edit', [$quiz->id, $question->id]) }}" class="btn btn-sm btn-primary"><i class="fa fa-pen"></i></a>
                                <a href="{{ route('questions.destroy', [$quiz->id, $question->id]) }}" class="btn btn-sm btn-danger"><i class="fa fa-times"></i></a>
                            </td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        </div>
    </div>
</x-app-layout>
