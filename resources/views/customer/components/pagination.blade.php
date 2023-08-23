@if ($paginator->hasPages())
<div class="pagination-area">
    <ul>
            {{-- Previous Page Link --}}
            @if ($paginator->onFirstPage())
                <li class="pagination-arrow disabled"><div><span class="fa fa-angle-left"></span></div></li>
            @else
                <li class="pagination-arrow">
                    <a href="{{ $paginator->previousPageUrl() }}">
                        <div><span class="fa fa-angle-left"></span></div>
                    </a>
                </li>
            @endif

            {{-- Pagination Elements --}}
            @foreach ($elements as $element)
                {{-- "Three Dots" Separator --}}
                @if (is_string($element))
                    <li class="pagination-number disabled" aria-disabled="true"><div>{{ $element }}</div></li>
                @endif

                {{-- Array Of Links --}}
                @if (is_array($element))
                    @foreach ($element as $page => $url)
                        @if ($page == $paginator->currentPage())
                            <li class="pagination-number active" aria-current="page"><div>{{ $page }}</div></li>
                        @else
                            <li class="pagination-number"><a href="{{ $url }}"><div>{{ $page }}</div></a></li>
                        @endif
                    @endforeach
                @endif
            @endforeach

            {{-- Next Page Link --}}
            @if ($paginator->hasMorePages())
                <li class="pagination-arrow">
                    <a href="{{ $paginator->nextPageUrl() }}">
                        <div><span class="fa fa-angle-right"></span></div>
                    </a>
                </li>
            @else
                <li class="pagination-arrow disabled">
                    <div><span class="fa fa-angle-right"></span></div>
                </li>
            @endif
        </ul>
    </div>
@endif
