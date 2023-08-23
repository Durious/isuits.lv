<?php

namespace App\Notifications;

use App\Models\Subscriber;
use App\Util\SocketUtil;
use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Messages\VonageMessage;
use Illuminate\Notifications\Notification;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Support\Facades\Log;

class ServiceCreated extends Notification implements ShouldQueue
{
    use Queueable;

    public $service;

    public function __construct($service)
    {
        $this->service = $service;
    }

    public function toMail($notifiable)
    {
        $data = [
            'name' => $this->service->name,
            'photo' => 'https://isuits.lv/storage/service/' . $this->service->photo,
            'description' => $this->service->description
        ];

        return (new MailMessage)
            ->subject('New Notification')
            ->view('emails.notification', $data);
    }

    public function toVonage($notifiable)
    {
        return (new VonageMessage)
            ->content("");
    }

    public function toArray($notifiable)
    {
        $data = 'New service created. Name: ' . $this->service['name'];

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
