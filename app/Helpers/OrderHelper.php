<?php

namespace App\Helpers;

use App\Models\Order;
use Illuminate\Support\Facades\DB;

class OrderHelper
{
    public static function calculateDiscount($discount = 0, $amount = 0)
    {
        if ($discount && $amount) {
            $dis_pos = strpos($discount, '%');
            if ($dis_pos !== false) {
                [$d_value] = explode('%', $discount);
                $discount  = formatDecimal((($amount * (float) $d_value) / 100), 2);
            }
        }
        return $discount;
    }

    public static function calculateTaxes($taxes, $amount, $qty = 1)
    {
        if (empty($taxes)) {
            return null;
        }

        $data                      = [];
        $compoundTaxes             = [];
        $totalNonCompoundTaxAmount = 0;
        foreach ($taxes as $tax) {
            if ($tax['compound']) {
                $compoundTaxes[] = $tax;
            } else {
                $calculated_on = $amount;
                $taxAmount     = formatDecimal($amount * $tax['rate'] / 100);
                $totalNonCompoundTaxAmount += $taxAmount;
                $data[$tax['id']] = ['calculated_on' => $calculated_on, 'amount' => $taxAmount, 'total_amount' => formatDecimal($taxAmount * $qty)];
            }
        }
        foreach ($compoundTaxes as $tax) {
            $calculated_on    = $amount + $totalNonCompoundTaxAmount;
            $taxAmount        = formatDecimal($calculated_on * $tax['rate'] / 100);
            $data[$tax['id']] = ['calculated_on' => $calculated_on, 'amount' => $taxAmount, 'total_amount' => formatDecimal($taxAmount * $qty)];
        }

        return collect($data);
    }

    public static function orderTransaction($data, Order $order = null)
    {
        return DB::transaction(function () use ($data, $order) {
            if ($order) {
                $order->update($data);
                $order->taxes()->detach();
                $order->services->each->delete();
            } else {
                $order = Order::create($data);
            }
            foreach ($data['services'] as $item) {
                $order->services()->create($item);
            }
            if ($data['taxes'] && $data['taxes']->isNotEmpty()) {
                $order->taxes()->sync($data['taxes']->toArray());
            }
            return $order;
        });
    }

    public static function prepare($v)
    {
        $services = collect($v['services'])->transform(function ($service) {
            $service['amount'] = formatDecimal(($service['qty'] * $service['price']), 2);
            return $service;
        });

        $v['services']        = $services;
        $v['total']           = formatDecimal($v['services']->sum('amount'), 2);
        $v['discount_amount'] = self::calculateDiscount($v['discount'], $v['total']);
        $v['taxes']           = self::calculateTaxes($v['taxes'], ($v['total'] - $v['discount_amount']));
        $v['tax_amount']      = $v['taxes'] ? formatDecimal($v['taxes']->sum('amount'), 2) : 0;
        $v['grand_total']     = formatDecimal($v['total'] - $v['discount_amount'] + $v['tax_amount'], 2);

        return $v;
    }
}
