<table class="profile-table">
    <thead>
        <tr>
            <th>{{_t('service', 1)}}</th>
            <th>{{_t('reference')}}</th>
            <th>{{_t('grand_total')}}</th>
            <th>{{_t('status')}}</th>
            <th>{{_t('priority')}}</th>
            <th class="text-right text-truncate">{{_t('delivery_date')}}</th>
        </tr>
    </thead>
    <tbody>
        @php
        $badge_color = [
            'Pending' => 'secondary',
            'Received' => 'warning',
            'Preparing' => 'info',
            'Ready' => 'primary',
            'Completed' => 'success',
        ];
        $priority_color = [
            'info',
            'warning',
            'danger'
        ];
        $priority_name = [
            'Normal',
            'High',
            'Urgent'
        ];
        @endphp
        @foreach ($service_orders as $order_item)
            <tr>
                <td>
                    @foreach($order_item->services as $cart_item)
                    <div>{{ $cart_item->name }}</div>
                    @endforeach
                </td>
                <td class="ff-monospace">{{$order_item->reference}}</td>
                <td>€{{number_format($order_item->grand_total, 2)}}</td>
                <td>
                    <span class="badge badge-{{$badge_color[$order_item->status]}}">
                        {{$order_item->status}}
                    </span>
                </td>
                <td>
                    <span class="badge badge-{{$priority_color[$order_item->priority - 1]}}">
                        {{$priority_name[$order_item->priority - 1]}}
                    </span>
                </td>
                <td class="text-right">{{$order_item->delivery_date->toDateString('Y:m:d')}}</td>
            </tr>
        @endforeach
    </tbody>
</table>
