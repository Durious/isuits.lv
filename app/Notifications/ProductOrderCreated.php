<?php

namespace App\Notifications;

use App\Util\SocketUtil;
use Illuminate\Bus\Queueable;
use Illuminate\Support\Facades\Log;
use Illuminate\Notifications\Notification;
use Illuminate\Contracts\Queue\ShouldQueue;

class ProductOrderCreated extends Notification implements ShouldQueue
{
    use Queueable;

    public $productOrder;

    public function __construct($productOrder)
    {
        $this->productOrder = $productOrder;
    }

    public function toArray($notifiable)
    {
        $data = 'New product order created. Reference: ' . $this->productOrder['reference'];

        SocketUtil::sendMessage($notifiable->id, $data);

        return [
            'data' => $data
        ];
    }

    public function via($notifiable)
    {
        return ['database'];
    }
}
