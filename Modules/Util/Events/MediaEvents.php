<?php

namespace Modules\Util\Events;

use Illuminate\Queue\SerializesModels;
use Illuminate\Foundation\Events\Dispatchable;

use Illuminate\Support\Facades\Storage;
class MediaEvents
{
    use SerializesModels, Dispatchable;

    public $paths;

    /**
     * Create a new event instance.
     *
     * @return void
     */
    public function __construct($type, $files, $folder, ...$args )
    {
        $paths = [];
        $permissions = $args[0] ?? null;
        $d = now()->format('d');
        $m = now()->format('m');
        $y = now()->format('Y');
        $directory = 'public/'.$y.'/'.$m.'/'.$d.'/'.$folder;
        Storage::makeDirectory($directory, 0755, true, true);
        foreach ($files as $file) {
            $path = Storage::put($directory, $file);

            array_push($paths, $path);
        }
        $this->paths = $paths;
    }

    public function handle()
    {
        return $this->paths;   
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
