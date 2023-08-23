<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;

class UserCreated extends Notification implements ShouldQueue
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
        return (new MailMessage)
            ->subject('New account created')
            ->greeting("Hello {$this->user->name},")
            ->line('Your new account has been created with following login credentials')
            ->line('Your Username: ' . $this->user->username)
            ->line('Your Password: ' . $this->password)
            ->action('Login', url('/'))
            ->line('Thank you!');
    }

    public function toVonage($notifiable)
    {
        return (new VonageMessage)
            ->content("Hello {$this->user->name}, We have created new account for you. Your username '{$this->user->username}' & password '{$password}'. Please visit {url('/')}.\nThanks, {{config('app.name')}}")->unicode();
    }

    public function via($notifiable)
    {
        return $this->user->account->via();
    }
}
