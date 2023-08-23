<?php

namespace App\Notifications;

use App\Util\SocketUtil;
use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Messages\VonageMessage;
use Illuminate\Notifications\Notification;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Support\Facades\Log;

class ProductCreated extends Notification implements ShouldQueue
{
    use Queueable;

    public $product;

    public function __construct($product)
    {
        $this->product = $product;
    }

    public function toMail(object $notifiable): ?MailMessage
    {
        $data = [
            'name' => $this->product->name,
            'photo' => 'https://isuits.lv/storage/product/' . $this->product->main_photo,
            'description' => $this->product->description,
        ];

        return (new MailMessage)
            ->subject('New Notification')
            ->view('emails.notification', $data);
    }

    public function toVonage($notifiable)
    {
        return (new VonageMessage)
            ->content("Hello, We have created new account for you. Your username");
    }

    public function toArray($notifiable)
    {
        $data = 'New product created. Name: ' . $this->product['name'];

        SocketUtil::sendMessage($notifiable->id, $data);

        return [
            'data' => $data
        ];
    }

    public function via($notifiable)
    {
        if (get_class($notifiable) === 'App\Models\Subscriber') {
            return ['mail'];
        } else {
            return ['database'];
        }
    }
}
