<div class="row">
    <div class="col-sm-6 col-md-4 col-lg-6 col-xl-4 py-2">
        <div class="btn-address" onclick="openShippingCreateModal(0)">
            <div class="text-center">
                <i class="fa fa-plus"></i>
                <div class="mt-2">{{_t('new_y', ['y' => _t('address')])}}</div>
            </div>
        </div>
    </div>
    @foreach(Auth::guard('customer')->user()->shipping_addresses as $item)
    <div class="col-sm-6 col-md-4 col-lg-6 col-xl-4 py-2">
        @php
            $selectable = $selectable ?? false;
        @endphp
        <div class="btn-address {{$item->is_default ? 'default' : ''}}" onclick="setDefaultShippingAddress({{$item->id}})">
            <div>
                <div class="text-center"><strong>{{$item->fname}} {{$item->lname}}</strong></div>
                <div class="text-address mt-3">{{$item->address}}</div>
                <div class="text-address">{{$item->city}}, {{$item->state}}, {{$item->country}}</div>
                @if(!$selectable)
                    <div class="btn-address-sm" onclick="openShippingCreateModal({{$item->id}}, event)">{{_t('edit')}}</div>
                @endif
            </div>
            @if(!$selectable)
            <div class="btn-address-delete" onclick="deleteShippingAddress({{$item->id}}, event)">&times;</div>
            @endif
        </div>
        <div class="mt-2 text-center default-address-mark">{!!$item->is_default ? _t('default') : '&nbsp;'!!}</div>
    </div>
    @endforeach
</div>