<?php

namespace App\Notifications;

use App\Util\SocketUtil;
use Illuminate\Bus\Queueable;
use Illuminate\Support\Facades\Log;
use Illuminate\Notifications\Notification;
use Illuminate\Contracts\Queue\ShouldQueue;

class ProductOrderUpdated extends Notification implements ShouldQueue
{
    use Queueable;

    public $productOrder;
    public $changes;

    public function __construct($productOrder, $changes)
    {
        $this->productOrder = $productOrder;
        $this->changes = $changes;
    }

    public function toArray($notifiable)
    {
        $updatedAt = '';
        $fieldName = '';
        $fieldValue = '';
        foreach ($this->changes as $field => $value) {
            if ($field == 'updated_at') {
                $updatedAt = $value;
            } else {
                $fieldName = $field;
                $fieldValue = $value;
            }
        }

        $data = "ProductOrder's " . $fieldName . ' changed into ' . $fieldValue . ' at ' . $updatedAt;

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
