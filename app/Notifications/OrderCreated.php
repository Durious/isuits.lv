<?php

namespace App\Notifications;

use App\Util\SocketUtil;
use Illuminate\Bus\Queueable;
use Illuminate\Support\Facades\URL;
use Illuminate\Notifications\Notification;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;

class OrderCreated extends Notification implements ShouldQueue
{
    use Queueable;

    public $order;

    public function __construct($order)
    {
        $this->order = $order;
    }

    public function toMail($notifiable)
    {
        $url = URL::signedRoute('orders.show', ['order' => $this->order->id, 'hash' => $this->order->hash]);
        return (new MailMessage())
            ->subject('New order created')
            ->greeting("Hello {$this->order->customer->name},")
            ->line('A new order has been created. Please click the button below to view your order.')
            ->action('View Order', $url)
            ->line('Thank you & we would love to do business with you again.');
    }

    public function toVonage($notifiable)
    {
        return (new VonageMessage())
            ->content("Hello {$this->order->customer->name}, A new order (No. {$this->order->id}) has been created.\nThanks, {{config('app.name')}}")->unicode();
    }

    public function toArray($notifiable)
    {
        $data = 'New service order created. Reference: ' . $this->order['reference'];

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
