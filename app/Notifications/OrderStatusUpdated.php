<?php

namespace App\Notifications;

use App\Util\SocketUtil;
use Illuminate\Bus\Queueable;
use Illuminate\Support\Facades\URL;
use Illuminate\Notifications\Notification;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;

class OrderStatusUpdated extends Notification implements ShouldQueue
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
            ->subject('Your order status updated')
            ->greeting("Hello {$this->order->customer->name},")
            ->line("Your order status has been updated to {$this->order->status}. Please click the button below to view your order.")
            ->action('View Order', $url)
            ->line('Thank you & we would love to do business with you again.');
    }

    public function toVonage($notifiable)
    {
        try {
            return (new VonageMessage())
                ->content("Hello {$this->order->customer->name}, Your order number {$this->order->id} has been updated, new order status is {$this->order->status}.\nThanks, {{config('app.name')}}")->unicode();
        } catch(\Exception $e) { // Using a generic exception
            dump('Mail not sent');
        }
    }

    public function toArray($notifiable)
    {
        $data = "Your order number {$this->order->id} has been updated, new order status is {$this->order->status}";

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
