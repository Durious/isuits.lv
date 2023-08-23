<table class="profile-table">
    <thead>
        <tr>
            <th>{{_t('order_no')}}</th>
            <th>{{_t('product')}}</th>
            <th>{{_t('price')}}</th>
            <th>{{_t('address')}}</th>
            <th>{{_t('gateway')}}</th>
            <th>{{_t('payment')}}</th>
            <th>{{_t('status')}}</th>
            <th class="text-right text-truncate">{{_t('order_date')}}</th>
        </tr>
    </thead>
    <tbody>
        @php
            $status_badge_color = [
                'Pending' => 'secondary',
                'Received' => 'info',
                'Completed' => 'success',
            ];
            $paid_badge_color = array();
            foreach ($order_statuses as $key => $item) {
                if($key === count($order_statuses) - 1) {
                    $paid_badge_color[$item] = 'success';
                } else if($key === 0) {
                    $paid_badge_color[$item] = 'secondary';
                } else {
                    $paid_badge_color[$item] = 'danger';
                }
            }
        @endphp
        @foreach ($product_orders as $order_item)
            <tr>
                <td class="ff-monospace">{{ $order_item->reference }}</td>
                <td>
                    @foreach($order_item->carts as $cart_item)
                    <div>{{ $cart_item->product->name }}</div>
                    @endforeach
                </td>
                <td>€{{ number_format($order_item->total_price(), 2) }}</td>
                <td>
                    {{ $order_item->shipping_address->address }}<br/>
                    {{ $order_item->shipping_address->city }},
                    {{ $order_item->shipping_address->state }}
                </td>
                <td>
                    {{ $order_item->gateway }}
                </td>
                <td>
                    <span class="badge badge-{{ $paid_badge_color[$order_item->paid_status] }} text-capitalize">{{ $order_item->paid_status }}</span>
                </td>
                <td>
                    <span class="badge badge-{{ $status_badge_color[$order_item->status] }}">{{ $order_item->status }}</span>
                </td>
                <td class="text-right">{{$order_item->created_at->toDateString('Y:m:d')}}</td>
            </tr>
        @endforeach
    </tbody>
</table>