<?php

namespace App\Observers;

use App\Models\Payment;
use App\Events\PaymentEvent;
use App\Notifications\{PaymentCreated, PaymentReceived};

class PaymentObserver
{
    public function created(Payment $payment)
    {
        if ($payment->received) {
            $t = $payment->customer->journal->debitDollars($payment->amount, 'payment_received')->referencesObject($payment);

            $payment->disableLogging();
            $payment->update(['transaction_id' => $t->id]);
            event(new PaymentEvent($payment));
            if (notDemo()) {
                $payment->customer->notify(new PaymentReceived($payment));
            }
        } else {
            if (notDemo()) {
                $payment->customer->notify(new PaymentCreated($payment));
            }
        }
    }

    public function deleted(Payment $payment)
    {
        if ($payment->received) {
            $payment->customer->journal->creditDollars($payment->amount, 'payment_deleted')->referencesObject($payment);
            event(new PaymentEvent($payment, false, true));
        }
    }

    public function forceDeleted(Payment $payment)
    {
        $payment->orders()->detach();
    }

    public function restored(Payment $payment)
    {
        if ($payment->received) {
            $payment->customer->journal->debitDollars($payment->amount, 'payment_restored')->referencesObject($payment);
            event(new PaymentEvent($payment));
        }
    }

    public function updated(Payment $payment)
    {
        if (!$payment->wasRecentlyCreated) {
            if ($payment->received) {
                if (!$payment->getOriginal('received')) {
                    $t = $payment->customer->journal
                        ->debitDollars($payment->amount, 'payment_received')
                        ->referencesObject($payment);

                    $payment->disableLogging();
                    $temp = $payment->getEventDispatcher();
                    $payment->unsetEventDispatcher();
                    $payment->update(['transaction_id' => $t->id]);
                    $payment->setEventDispatcher($temp);
                    event(new PaymentEvent($payment));
                    if (notDemo()) {
                        $payment->customer->notify(new PaymentReceived($payment));
                    }
                } elseif ($payment->isDirty('amount')) {
                    log_activity('Updating payment', $payment, $payment->customer);

                    $payment->customer->journal
                        ->creditDollars($payment->getOriginal('amount'), 'payment_editing')
                        ->referencesObject($payment);

                    $payment->customer->journal
                        ->debitDollars($payment->amount, 'payment_updated')
                        ->referencesObject($payment);

                    event(new PaymentEvent($payment, true));
                }
            }
        }
    }
}
