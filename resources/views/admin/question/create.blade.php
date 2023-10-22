<x-app-layout>
    <x-slot name="header">{{ $quiz->title }} Buat Pertanyaan Baru</x-slot>

    <div class="card">
        <div class="card-body">
            <form method="POST" action="{{ route('questions.store', $quiz->id) }}" enctype="multipart/form-data">
                @csrf
                <div class="form-group">
                    <label for="">Pertanyaan</label>
                    <textarea name="question" class="form-control mt-1 mb-2" value="" id="" rows="4">{{ old('question') }}</textarea>
                </div>
                <div class="form-group">
                    <label for="">Foto</label>
                    <input type="file" name="image" class="form-control mt-1 mb-2">
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="">Jawaban 1</label>
                            <textarea name="answer1" class="form-control mt-1 mb-2" value="" id="" rows="2">{{ old('answer1') }}</textarea>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="">Jawaban 2</label>
                            <textarea name="answer2" class="form-control mt-1 mb-2" value="" id="" rows="2">{{ old('answer2') }}</textarea>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="">Jawaban 3</label>
                            <textarea name="answer3" class="form-control mt-1 mb-2" value="" id="" rows="2">{{ old('answer3') }}</textarea>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="">Jawaban 4</label>
                            <textarea name="answer4" class="form-control mt-1 mb-2" value="" id="" rows="2">{{ old('answer4') }}</textarea>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="">Jawaban Benar</label>
                    <select name="correct_answer" id="" class="form-control mb-2 mt-2">
                        <option @if (old('correct_answer') === 'answer1') selected @endif value="answer1">Jawaban 1</option>
                        <option @if (old('correct_answer') === 'answer2') selected @endif value="answer2">Jawaban 2</option>
                        <option @if (old('correct_answer') === 'answer3') selected @endif value="answer3">Jawaban 3</option>
                        <option @if (old('correct_answer') === 'answer4') selected @endif value="answer4">Jawaban 4</option>
                    </select>
                </div>

                <div class="form-group d-grid gap-2">
                    <button class="btn btn-success btn-sm " type="submit">Buat Pertanyaan</button>
                </div>
            </form>
        </div>
    </div>
</x-app-layout>
