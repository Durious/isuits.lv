<?php

namespace App\Notifications;

use App\Util\SocketUtil;
use Illuminate\Bus\Queueable;
use Illuminate\Support\Facades\URL;
use Illuminate\Notifications\Notification;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;

class PaymentReceived extends Notification implements ShouldQueue
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
            ->subject('Payment received')
            ->greeting("Hello {$this->payment->customer->name},")
            ->line('This is to confirm that we have received a payment of ' . $this->payment->amount . ($this->payment->gateway ? ' by ' . ($this->payment->gateway . ($this->payment->gateway_transaction_id ? ' (Transaction Id: ' . $this->payment->gateway_transaction_id . ')' : '')) . '. ' : '') . 'You can view the payment note by clicking the button below')
            ->action('View Payment Note', $url)
            ->line('Thank you very much!');
    }

    public function toVonage($notifiable)
    {
        return (new VonageMessage)
            ->content("Hello {$this->payment->customer->name}, We have received payment (No. {$this->payment->id}) of {$this->payment->amount}.\nThanks, {{config('app.name')}}")->unicode();
    }

    public function toArray($notifiable)
    {
        $data = "{$this->payment->customer->name}, We have received payment (No. {$this->payment->id}) of {$this->payment->amount}.";

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
