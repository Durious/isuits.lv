<?php

namespace App\Notifications;

use App\Util\SocketUtil;
use Illuminate\Bus\Queueable;
use Illuminate\Support\Facades\URL;
use Illuminate\Notifications\Notification;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;

class PaymentCreated extends Notification implements ShouldQueue
{
    use Queueable;

    public $payment;

    public function __construct($payment)
    {
        $this->payment = $payment;
    }

    public function toMail($notifiable)
    {
        $url = URL::signedRoute('payments.show', ['payment' => $this->payment->id, 'hash' => $this->payment->hash]);
        return (new MailMessage)
            ->subject('Payment request created')
            ->greeting("Hello {$notifiable->name},")
            ->line('A new payment request has been created. Please click the button below to view payment request.')
            ->action('View Payment Request', $url)
            ->line('Thank you for doing business with us and we would appreciate if you could make payment at your earliest convenience.');
    }

    public function toVonage($notifiable)
    {
        return (new VonageMessage)
            ->content("Hello {$notifiable->name}, A new payment request (No. {$this->payment->id}) has been created.\nThanks, {{config('app.name')}}")->unicode();
    }

    public function toArray($notifiable)
    {
        $data = "A new payment request (No. {$this->payment->id}) has been created.";

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
