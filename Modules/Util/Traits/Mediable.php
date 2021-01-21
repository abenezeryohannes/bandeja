<?php


namespace Modules\Util\Traits;

use Modules\Util\Events\MediaEvents;
use Modules\Util\Jobs\StoreMediaFile;
trait Mediable
{
    private $_media = [];

    // protected $media_folder = "uncategorized";

    protected static function bootMediable()
    {
        static::saving(function ($model) {

            $media_columns = $model->media_columns ?? ['media_data'];
            $media = collect($model->_media)->groupBy('column')->toArray();
            // dd($media->toArray() ,$model->_media, $model);

            foreach ($media as $column => $files) {
                // dd($column);
                $paths = StoreMediaFile::dispatchNow("store", $files, $model->media_folder ?? 'uncategorized');
                $model[$column] = [ 
                    'files' => $paths,
                    'permissions' => []
                ];
                // dd($model);
            }
            
        });
    }

    protected function initializeMediable()
    {
        // dump('init', $this);
        $media_columns = $this->media_columns ?? ['media_data'];
        foreach ($media_columns as $media_column) {
            $this->mergeCasts([
                    $media_column => 'array'
            ]);
        }
    }

    public function remove_media($v)
    {
        return $v.$v;
    }


    /*
    * needs [ 'media_data'  ] in fillables
    * needs [ 'media_data' => 'array'  ] in casts
    *
    */

    public function set_media($column, $file)
    {
        array_push($this->_media, compact('column','file'));
    }

    public function setMediaAttribute($t)
    {
        array_push($this->_media, $t);
        // $this->_media = $t;
    }

    public function getMediaAttribute()
    {

    }
}