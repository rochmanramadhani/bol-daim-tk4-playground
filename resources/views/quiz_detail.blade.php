<x-app-layout>
    <x-slot name="header">{{ $quiz->title }}</x-slot>
    <div class="card">
        <div class="card-body">
            <p class="card-text">
            <div class="row">
                <div class="col-md-4">
                    <ul class="list-group">
                        @if ($quiz->my_rank)
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                Peringkat Anda
                                <span title="" class="badge bg-primary rounded-pill">#{{ $quiz->my_rank }}</span>
                            </li>
                        @endif
                        @if ($quiz->my_result)
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                Skor
                                <span title="" class="badge bg-primary rounded-pill">{{ $quiz->my_result->point }}</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                Jumlah Benar / Salah
                                <div class="float-end">
                                    <span title="" class="badge bg-success rounded-pill">{{ $quiz->my_result->correct }}
                                        Benar</span>
                                    <span title="" class="badge bg-danger rounded-pill">{{ $quiz->my_result->wrong }}
                                        Salah</span>
                                </div>
                            </li>
                        @endif
                        @if ($quiz->finished_at)
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                Batas Waktu Terakhir
                                <span title="{{ $quiz->finished_at }}" class="badge bg-secondary rounded-pill">{{ $quiz->finished_at->diffForHumans() }}</span>
                            </li>
                        @endif
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            Jumlah Soal
                            <span class="badge bg-secondary rounded-pill">{{ $quiz->questions_count }}</span>
                        </li>
                        @if ($quiz->details)
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                Jumlah Peserta
                                <span class="badge bg-warning rounded-pill">{{ $quiz->details['join_count'] }}</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                Skor Rata-Rata
                                <span class="badge bg-info rounded-pill">{{ $quiz->details['average'] }}</span>
                            </li>
                        @endif
                    </ul>
                    @if (count($quiz->topTen) > 0)
                        <div class="card mt-3">
                            <div class="card-body">
                                <h5 class="card-title"><i class="fas fa-crown"></i> &nbsp;Top 10</h5>
                                <ul class="list-group">
                                    @foreach ($quiz->topTen as $result)
                                        <li class="list-group-item d-flex justify-content-between align-items-center">
                                            <div class="col-md-2">
                                                <strong class="h4">{{ $loop->iteration }}.</strong>
                                            </div>
                                            <div class="col-md-2">
                                                <img src="{{ $result->user->profile_photo_url }}" alt="" class="w-8 h-8 rounded-pill">
                                            </div>
                                            <div class="col-md-6">
                                                <span @if (auth()->user()->id == $result->user_id) class="text-danger" @endif>{{ $result->user->name }}</span>
                                            </div>
                                            <div class="col-md-4">
                                                <span class="badge bg-success rounded-pill">{{ $result->point }}</span>
                                            </div>
                                        </li>
                                    @endforeach
                                </ul>
                            </div>
                        </div>
                    @endif
                </div>
                <div class="col-md-8">
                    {{ $quiz->description }}
                    @if ($quiz->my_result)
                        <div class="d-grid gap-2">
                            <a href="{{ route('quiz.join', $quiz->slug) }}" class="btn btn-info btn-sm">Lihat Jawaban Saya</a>
                        </div>
                    @elseif (!$quiz->finished_at)
                        <div class="d-grid gap-2">
                            <a href="{{ route('quiz.join', $quiz->slug) }}" class="btn btn-primary btn-sm">Ikuti Quiz</a>
                        </div>
                    @elseif ($quiz->finished_at > now())
                        <div class="d-grid gap-2">
                            <a href="{{ route('quiz.join', $quiz->slug) }}" class="btn btn-primary btn-sm">Ikuti Quiz</a>
                        </div>
                    @endif
                </div>
            </div>
            </p>
        </div>
    </div>
</x-app-layout>
