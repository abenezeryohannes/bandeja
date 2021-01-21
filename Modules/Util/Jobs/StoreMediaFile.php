<?php

namespace Modules\Util\Jobs;

use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;

use Illuminate\Support\Facades\Storage;
class StoreMediaFile implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $paths = [];

    private $directory;
    private $files;
    /**
     * Create a new job instance.
     *
     * @return void
     */
    public function __construct($type, $files, $folder, ...$args )
    {
        $this->files = $files;
        $permissions = $args[0] ?? null;
        $d = now()->format('d');
        $m = now()->format('m');
        $y = now()->format('Y');
        $this->directory = 'public/'.$y.'/'.$m.'/'.$d.'/'.$folder;
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        $paths = [];
        Storage::makeDirectory($this->directory, 0755, true, true);
        foreach ($this->files as $file) {
            $path = Storage::put($this->directory, $file['file']);
            array_push($paths, $path);
        }
        $this->paths = $paths;
            

        return $this->paths;
    }
}
