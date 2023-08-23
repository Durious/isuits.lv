<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Support\Carbon;

class CustomerLogged extends Notification implements ShouldQueue
{
    use Queueable;
    public $ip;
    public $agent;

    public function __construct($ip, $agent)
    {
        $this->ip = $ip;
        $this->agent = $agent;
    }

    public function toArray($notifiable)
    {
        return [
            'data' => 'Logged in (IP: ' . $this->ip . ', AGENT: ' . $this->agent . ', TIME: ' . Carbon::now() . ')'
        ];
    }

    public function via($notifiable)
    {
        return ['database'];
    }
}
