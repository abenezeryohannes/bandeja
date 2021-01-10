<?php


namespace Modules\Util\Traits;

use Modules\Util\Events\MediaEvents;
trait Mediable
{
    private $_media = [];

    protected $folder = "uncategorized";

    protected static function bootMediable()
    {
        static::saving(function ($model) {
            $model->media_data = [
                'files' => $model->_media,
                'permissions' => []
            ];
            MediaEvents::dispatch("store", $model->_media, $model->folder);
            
        });
    }

    protected function initializeMediable()
    {
        // dump('init', $this);
        $this->mergeCasts([
                'media_data' => 'array'
            ]);
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

    public function setMediaAttribute($t)
    {
        array_push($this->_media, $t);
        // $this->_media = $t;
    }

    public function getMediaAttribute()
    {

    }
}