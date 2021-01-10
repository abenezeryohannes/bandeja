<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\App;
/*
*
* https://phrase.com/blog/posts/laravel-i18n-modelling-best-practices/
*/
abstract class LocalizableModel extends Model
{
	/**
     * Localized attributes.
     *
     * @var array
     */
    protected $localizable = [];

    protected $supported_locales = ['en', 'am'];
    /**
     * Whether or not to hide translated attributes e.g. name_en
     *
     * @var boolean
     */
    protected $hideLocaleSpecificAttributes = true;
    /**
     * Whether or not to append translatable attributes to array
     * output e.g. name
     *
     * @var boolean
     */
    protected $appendLocalizedAttributes = true;
    /**
     * Make a new translatable model
     *
     * @param array $attributes
     */
    public function __construct($attributes = [])
    {
        // We dynamically append localizable attributes to array output
        // and hide the localized attributes from array output
        foreach($this->localizable as $localizableAttribute) {
            if ($this->appendLocalizedAttributes) {
                $this->appends[] = $localizableAttribute;
            }
            if ($this->hideLocaleSpecificAttributes) {
                foreach($this->supported_locales as $locale) {
                    $this->hidden[] = $localizableAttribute.'_'.$locale;
                }
            }
        }
        parent::__construct($attributes);
    }
    /**
     * Magic method for retrieving a missing attribute.
     *
     * @param string $attribute
     * @return mixed
     */
    public function __get($attribute)
    {
        // We determine the current locale and return the associated
        // locale-specific attribute e.g. name_en
        if (in_array($attribute, $this->localizable)) {
            $localeSpecificAttribute = $attribute.'_'.app()->currentLocale();
            return $this->{$localeSpecificAttribute};
        }
        return parent::__get($attribute);
    }
    /**
     * Magic method for calling a missing instance method.
     *
     * @param string $method
     * @param array $arguments
     * @return mixed
     */
    public function __call($method, $arguments)
    {
        // We handle the accessor calls for all our localizable attributes
        // e.g. getNameAttribute()
        foreach($this->localizable as $localizableAttribute) {
            if ($method === 'get'.Str::studly($localizableAttribute).'Attribute') {
                return $this->{$localizableAttribute};
            }
        }
        return parent::__call($method, $arguments);
    }

}
