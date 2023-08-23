<div class="shop-sidebar">
    <form action="{{ route('customer.products', ['type' => $type] + request()->except('search')) }}"
        method="GET">
        @if (request()->input('type'))
            <input type="hidden" name="type" value="{{ request()->input('type') }}">
        @endif
        @if (request()->input('category'))
            <input type="hidden" name="category" value="{{ request()->input('category') }}">
        @endif
        @if (request()->input('sort'))
            <input type="hidden" name="sort" value="{{ request()->input('sort') }}">
            <input type="hidden" name="sort_dir" value="{{ request()->input('sort_dir') }}">
        @endif
        @if (request()->input('price'))
            <input type="hidden" name="price" value="{{ request()->input('price') }}">
        @endif
        <input type="text" name="search" class="search-input" placeholder="Search"
            onfocus="this.placeholder = ''" onblur="this.placeholder = 'Search'"
            value="{{ $search }}" />
        <button type="submit" class="search-button">
            <i class="fa fa-search"></i>
        </button>
    </form>

    <div class="categories">
        <div class="title">
            <h4>{{_t('category', 2)}}</h4>
        </div>
        <ul>
            <li>
                <a
                    href="{{ route('customer.products', ['type' => $type] + request()->except('category', 'page')) }}">
                    {{_t('all')}}
                </a>
            </li>
            @foreach ($categories as $item)
                <li>
                    <a class="{{ $item->id == $category ? 'active' : '' }}"
                        href="{{ route('customer.products', ['type' => $type, 'category' => $item->id] + request()->except('category', 'page')) }}">
                        {{ $item->name }}
                    </a>
                </li>
            @endforeach
        </ul>
    </div>

    <div class="price">
        <div class="title">
            <h4>{{_t('price')}}</h4>
        </div>
        <ul>
            @php
                $price_option_list = ['$0 - $20', '$20 - $60', '$60 - $100', '$100 - $150', '$150 - $200', '> $200'];
            @endphp
            <li>
                <a
                    href="{{ route('customer.products', ['type' => $type] + request()->except('price', 'page')) }}">
                    {{_t('all')}}
                </a>
            </li>
            @foreach ($price_option_list as $key => $item)
                <li>
                    <a class="{{ $price != null && $key == $price ? 'active' : '' }}"
                        href="{{ route('customer.products', ['type' => $type, 'price' => $key] + request()->except('price', 'page')) }}">
                        {{ $item }}
                    </a>
                </li>
            @endforeach
        </ul>
    </div>

    <div class="reset">
        <div class="title">
            <h4><a href="{{ route('customer.products', ['type' => $type]) }}">{{_t('reset')}}</a></h4>
        </div>
    </div>
</div>