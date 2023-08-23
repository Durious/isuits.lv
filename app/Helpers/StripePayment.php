<?php

namespace App\Helpers;

use Stripe\Charge;
use Stripe\Stripe;

class StripePayment
{
    public function __construct()
    {
        Stripe::setApiKey(env('STRIPE_SECRET'));
    }

    public function charge($data)
    {
        $charge = [];
        try {
            $charge['data'] = Charge::create([
                'source'      => $data['token_id'],
                'description' => $data['description'],
                'amount'      => $data['amount'] * 100,
                'currency'    => env('STRIPE_CURRENCY'),
            ]);
            $charge['error'] = false;
        } catch (\Stripe\Exception\CardException $e) {
            $charge['error']   = true;
            $charge['message'] = $e->getError()->message;
        } catch (\Stripe\Exception\RateLimitException $e) {
            $charge['error']   = true;
            $charge['message'] = $e->getError()->message;
        } catch (\Stripe\Exception\InvalidRequestException $e) {
            $charge['error']   = true;
            $charge['message'] = $e->getError()->message;
        } catch (\Stripe\Exception\AuthenticationException $e) {
            $charge['error']   = true;
            $charge['message'] = $e->getError()->message;
        } catch (\Stripe\Exception\ApiConnectionException $e) {
            $charge['error']   = true;
            $charge['message'] = $e->getError()->message;
        } catch (\Stripe\Exception\ApiErrorException $e) {
            $charge['error']   = true;
            $charge['message'] = $e->getError()->message;
        } catch (Exception $e) {
            $charge['error']   = true;
            $charge['message'] = $e->getMessage();
        }
        return $charge;
    }
}
