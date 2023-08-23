@foreach(Auth::guard('customer')->user()->likes as $favorite_item)
<tr class="favorite-item">
    <td>
        <img src="{{asset('/storage/product/'.$favorite_item->main_photo)}}" height="70" />
    </td>
    <td>{{$favorite_item->name}}</td>
    <td>{{$favorite_item->category->name}}</td>
    <td class="text-capitalize">{{$favorite_item->type}}</td>
    <td class="text-right">€{{number_format($favorite_item->price, 2)}}</td>
    <td class="text-right">
        <span class="cursor-pointer" onclick="addToCart({{$favorite_item->id}}, event)">
            <i class="fa fa-cart-plus"></i>
        </span>
        <span class="cursor-pointer ml-4" onclick="removeFavorite({{$favorite_item->id}})">
            <i class="fa fa-trash-o"></i>
        </span>
    </td>
</tr>
@endforeach
@if(count(Auth::guard('customer')->user()->likes) === 0)
<tr>
    <td colspan="6" class="py-5 text-center">
        {{_t('no_favorites')}}
    </td>
</tr>
@endif