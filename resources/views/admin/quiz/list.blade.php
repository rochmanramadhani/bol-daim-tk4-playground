<x-app-layout>
    <x-slot name="header">Quiz</x-slot>
    <div class="card">
        <div class="card-body">
            <h5 class="card-title float-end">
                <a href="{{ route('quizzes.create') }}" class="btn btn-sm btn-primary"><i class="fa fa-plus"></i> Buat Quiz</a>
            </h5>
            <form action="" method="GET" class="mb-2">
                <div class="form row">
                    <div class="col-md-2">
                        <input type="text" name="title" class="form-control" value="{{ request()->get('title') }}" placeholder="Nama Quiz">
                    </div>
                    <div class="col-md-2">
                        <select name="status" id="" onchange="this.form.submit()" class="form-control">
                            <option value="">Pilih Status</option>
                            <option @if (request()->get('status') === 'publish') selected @endif value="publish">Aktif</option>
                            <option @if (request()->get('status') === 'passive') selected @endif value="selesai">Selesai</option>
                            <option @if (request()->get('status') === 'draft') selected @endif value="draft">Draft</option>
                        </select>
                    </div>
                    @if (request()->get('title') || request()->get('status'))
                        <div class="col-md-2">
                            <a href="{{ route('quizzes.index') }}" class="btn btn-secondary ">Reset</a>
                        </div>
                    @endif
                </div>
            </form>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th scope="col">Quiz</th>
                        <th scope="col">Jumlah Pertanyaan</th>
                        <th scope="col">Status</th>
                        <th scope="col">Tanggal Berakhir</th>
                        <th scope="col">Aksi</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($quizzes as $quiz)
                        <tr>
                            <td>{{ Str::limit($quiz->title, 20) }}</td>
                            <td>{{ $quiz->questions_count }}</td>
                            <td>
                                @switch($quiz->status)
                                    @case('publish')
                                        @if (!$quiz->finished_at)
                                            <span class="badge bg-success">Aktif</span>
                                        @elseif($quiz->finished_at > now())
                                            <span class="badge bg-success">Aktif</span>
                                        @else
                                            <span class="badge bg-secondary">Tutup</span>
                                        @endif
                                    @break

                                    @case('passive')
                                        <span class="badge bg-danger">Selesai</span>
                                    @break

                                    @case('draft')
                                        <span class="badge bg-warning">Draft</span>
                                    @break
                                @endswitch
                            </td>
                            <td>
                                <span title="{{ $quiz->finished_at }}">
                                    {{ $quiz->finished_at ? $quiz->finished_at->diffForHumans() : '-' }}
                                </span>
                            </td>
                            <td>
                                <a href="{{ route('quizzes.details', $quiz->id) }}" class="btn btn-sm btn-outline-info rounded-pill"><i class="fa fa-info-circle"></i></a>
                                <a href="{{ route('questions.index', $quiz->id) }}" class="btn btn-sm btn-outline-warning rounded-pill"><i class="fa fa-question"></i></a>
                                <a href="{{ route('quizzes.edit', $quiz->id) }}" class="btn btn-sm btn-outline-primary rounded-pill"><i class="fa fa-pen"></i></a>
                                <a href="{{ route('quizzes.destroy', $quiz->id) }}" onclick="return confirm('Anda yakin ingin menghapus quiz?')" class="btn btn-sm btn-outline-danger rounded-pill"><i class="fa fa-times"></i></a>
                            </td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
            {{ $quizzes->withQueryString()->links() }}
        </div>
    </div>
</x-app-layout>
