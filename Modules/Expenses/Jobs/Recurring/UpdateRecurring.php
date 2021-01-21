<?php

namespace Modules\Expenses\Jobs\Recurring;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Modules\Expenses\Entities\Recurring;

class UpdateRecurring implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $recurring = null;
    protected $id = 0;
    protected $request;
    protected $response = null;

    /**
     * Create a new job instance.
     *
     * @param  $request
     */
    public function __construct($request, $id)
    {
        $this->request = ($request);
        $this->id = $id;
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {

        \DB::transaction(function() {
            $this->recurring = Recurring::find($this->id);
            if($this->recurring == null){
                $this->response =  "No recurring with this id found!";
            }else {
                $this->recurring->update($this->request->all());
            }
        });
        return ($this->response == null)? $this->recurring : $this->response;
    }
}
