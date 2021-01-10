<?php

namespace Modules\Util\Events;

use Illuminate\Queue\SerializesModels;
use Illuminate\Foundation\Events\Dispatchable;

use Illuminate\Support\Facades\Storage;
class MediaEvents
{
    use SerializesModels, Dispatchable;

    /**
     * Create a new event instance.
     *
     * @return void
     */
    public function __construct($type, $files, $folder, ...$args )
    {
        $permissions = $args[0] ?? null;
        // dd($t, $args);
        $d = now()->format('d');
        $m = now()->format('m');
        $y = now()->format('Y');
        $directory = 'public/'.$y.'/'.$m.'/'.$d.'/'.$folder;
        // $directory = 'public/'.$y.'/'.$m.'/'.$d;
        // $directory = 'public/'.$y;
            Storage::makeDirectory($directory, 0755, true, true);
        foreach ($files as $file) {
            # code...
        Storage::put($directory, $file);
        }

    }

    public function handle($event)
    {
        // dd($event);
    }

    /**
     * Get the channels the event should be broadcast on.
     *
     * @return array
     */
    public function broadcastOn()
    {
        return [];
    }
}
