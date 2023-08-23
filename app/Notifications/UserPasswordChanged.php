<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;

class UserPasswordChanged extends Notification implements ShouldQueue
{
    use Queueable;

    public $password;
    public $user;

    public function __construct($user, $password)
    {
        $this->user = $user;
        $this->password = $password;
    }

    public function toMail($notifiable)
    {
        return (new MailMessage())
            ->subject('Your account password changed')
            ->greeting("Hello {$this->user->name},")
            ->line('Your account password has been reset as following')
            ->line('Your Username: ' . $this->user->username)
            ->line('Your Password: ' . $password)
            ->action('Login', url('/'))
            ->line('Thank you!');
    }

    public function toVonage($notifiable)
    {
        return (new VonageMessage())
            ->content("Hello {$this->user->name}, Your account password has been reset. Your username '{$this->user->username}' & password '{$password}'. Please visit {url('/')}.\nThanks, {{config('app.name')}}")->unicode();
    }

    public function via($notifiable)
    {
        return $this->user->account->via();
    }
}
