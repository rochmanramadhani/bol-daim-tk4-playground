<x-app-layout>
    <x-slot name="header">{{ $quiz->title }} Halaman Hasil</x-slot>
    <div class="card">
        <div class="card-body">
            <h3><i class="fas fa-award"></i>&nbsp;&nbsp;Skor yang Anda Dapatkan: <strong>{{ $quiz->my_result->point }}</strong></h3>
            <div class="alert alert-info" role="alert">
                <h2 class="card-text"><i class="fas fa-info"></i> &nbsp;Informasi</h2>
                <i class="fa fa-check text-success mt-2"></i> : Jawaban Benar <br>
                <i class="fa fa-user text-dark mt-2"></i> : Jawaban Anda <br>
                <i class="fa fa-times text-danger mt-2"></i> : Jawaban Salah <br>
            </div>
            @foreach ($quiz->questions as $question)
                @if ($question->correct_answer == $question->my_answer->answer)
                    <i class="fa fa-check text-success"></i>
                @else
                    <i class="fa fa-times text-danger"></i>
                @endif
                <strong> #{{ $loop->iteration }}.</strong>{{ $question->question }}
                @if ($question->image)
                    <img src="{{ asset($question->image) }}" alt="" class="img-responsive" style="width: 60%; border-radius:5px">
                @endif
                <div class="form-check ml-3 mt-2">
                    @if ('answer1' == $question->correct_answer)
                        <i class="fa fa-check text-success"></i>
                    @elseif('answer1' == $question->my_answer->answer)
                        <i class="fa fa-user text-dark"></i>
                    @else
                        <i class="fa fa-times text-danger"></i>
                    @endif
                    <label class="form-check-label" for="quiz{{ $question->id }}1">
                        {{ $question->answer1 }}
                    </label>
                </div>
                <div class="form-check ml-3">
                    @if ('answer2' == $question->correct_answer)
                        <i class="fa fa-check text-success"></i>
                    @elseif('answer2' == $question->my_answer->answer)
                        <i class "fa fa-user text-dark"></i>
                    @else
                        <i class="fa fa-times text-danger"></i>
                    @endif
                    <label class="form-check-label" for="quiz{{ $question->id }}2">
                        {{ $question->answer2 }}
                    </label>
                </div>
                <div class="form-check ml-3">
                    @if ('answer3' == $question->correct_answer)
                        <i class="fa fa-check text-success"></i>
                    @elseif('answer3' == $question->my_answer->answer)
                        <i class="fa fa-user text-dark"></i>
                    @else
                        <i class="fa fa-times text-danger"></i>
                    @endif
                    <label class="form-check-label" for="quiz{{ $question->id }}3">
                        {{ $question->answer3 }}
                    </label>
                </div>
                <div class="form-check ml-3">
                    @if ('answer4' == $question->correct_answer)
                        <i class="fa fa-check text-success"></i>
                    @elseif('answer4' == $question->my_answer->answer)
                        <i class="fa fa-user text-dark"></i>
                    @else
                        <i class="fa fa-times text-danger"></i>
                    @endif
                    <label class="form-check-label" for="quiz{{ $question->id }}4">
                        {{ $question->answer4 }}
                    </label>
                </div>
                @if ($question->correct_answer == $question->my_answer->answer)
                    <div class="alert alert-success mt-2" role="alert">
                        <i class="fa fa-check"></i>&nbsp; Anda menjawab pertanyaan ini dengan benar.
                        <hr><i class="fas fa-info-circle"></i>&nbsp; Sebanyak %{{ $question->true_percent }} peserta juga menjawab pertanyaan ini dengan benar.
                    </div>
                @else
                    <div class="alert alert-danger mt-2" role="alert">
                        <i class="fa fa-check"></i>&nbsp; Anda menjawab pertanyaan ini dengan salah.
                        <hr><i class="fas fa-info-circle"></i>&nbsp; Sebanyak %{{ $question->true_percent }} peserta menjawab pertanyaan ini dengan benar.
                    </div>
                @endif
                <hr>
            @endforeach
        </div>
    </div>
</x-app-layout>
