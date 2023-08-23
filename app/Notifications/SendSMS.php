<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use Illuminate\Contracts\Queue\ShouldQueue;

class SendSMS extends Notification implements ShouldQueue
{
    use Queueable;

    public $customer;
    public $message;

    public function __construct($customer, $message)
    {
        $this->customer = $customer;
        $this->message = $message;
    }

    public function toVonage($notifiable)
    {
        return (new VonageMessage())
                ->content("Hello {$this->customer->name}, $this->message\nThanks, {{config('app.name')}}")->unicode();
    }

    public function via($notifiable)
    {
        return $notifiable->account->sms_enabled ? ['vonage'] : [];
    }
}
