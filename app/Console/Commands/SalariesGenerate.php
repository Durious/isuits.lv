<?php

namespace App\Console\Commands;

use App\Models\User;
use App\Models\Salary;
use App\Models\Activity;
use Illuminate\Console\Command;

class SalariesGenerate extends Command
{
    protected $description = 'Generate staff salaries';

    protected $signature = 'salaries:generate';

    public function __construct()
    {
        parent::__construct();
    }

    public function handle()
    {
        $users  = User::withoutGlobalScopes()->get();
        $end    = now()->endOfMonth()->format('Y-m-d');
        $start  = now()->startOfMonth()->format('Y-m-d');
        $salary = ['date' => now()->format('Y-m-d'), 'advance' => null, 'description' => 'Generating salaries with command.'];
        $users->each(function ($user) use ($salary, $start, $end) {
            $already = Salary::withoutGlobalScopes()->whereBetween('date', [$start, $end])->where('user_id', $user->id)->get();
            if ($already) {
                $advance = Salary::withoutGlobalScopes()->orWhere(function ($query) use ($start, $end) {
                    $query->whereDate('date', '>=', $start)->whereDate('date', '<=', $end);
                })->where('user_id', $user->id)->advance()->get();
                $salary['user_id'] = $user->id;
                $salary['staff_id'] = $user->id;
                $salary['account_id'] = $user->account_id;
                if ($user->salary && $advance->isNotEmpty()) {
                    $advance_amount = $advance->sum('amount');
                    $salary['amount'] = $user->salary - $advance_amount;
                    $salary = new Salary($salary);
                    $salary->disableLogging();
                    $salary->save();
                    $advance->each->update(['settled_on' => now()]);
                    activity('Salary')->performedOn($salary)
                    ->tap(function (Activity $activity) use ($user) {
                        $activity->account_id = $user->account_id;
                    })->log("User ({$user->name}) salary after advance created {($user->salary - $advance_amount)}");
                    $this->info("User ({$user->name}) salary after advance created {($user->salary - $advance_amount)}");
                } elseif ($user->salary) {
                    $salary['amount'] = $user->salary;
                    $salary['account_id'] = $user->account_id;
                    $salary = new Salary($salary);
                    $salary->disableLogging();
                    $salary->save();
                    activity('Salary')->performedOn($salary)
                    ->tap(function (Activity $activity) use ($user) {
                        $activity->account_id = $user->account_id;
                    })->log("User ({$user->name}) salary created {$user->salary}");
                    $this->info("User ({$user->name}) salary created {$user->salary}");
                } else {
                    activity('Salary')->tap(function (Activity $activity) use ($user) {
                        $activity->account_id = $user->account_id;
                    })->log("User ({$user->name}) do not have salary.");
                    $this->info("User ({$user->name}) do not have salary.");
                }
            } else {
                activity('Salary')->tap(function (Activity $activity) use ($user) {
                    $activity->account_id = $user->account_id;
                })->log("User ({$user->name}) salary is already paid.");
                $this->error("User ({$user->name}) salary is already paid.");
            }
        });
    }
}
