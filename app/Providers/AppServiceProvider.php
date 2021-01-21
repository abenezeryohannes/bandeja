<?php

namespace App\Providers;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\Resources\Json\JsonResource;
use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Arr as arr;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        //
    }

    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        //
        
        JsonResource::withoutWrapping();

        Builder::macro('whereLike', function ($attributes, string $searchTerm) {
            $this->where(function (Builder $query) use ($attributes, $searchTerm) {
                foreach (Arr::wrap($attributes) as $attribute) {
                    $query->orWhere($attribute, 'LIKE', "%{$searchTerm}%");
                }
            });

            return $this;
        });


        Builder::macro('whereLikeIn', function ($attributes, string $searchTerm) {
            $this->where(function (Builder $query) use ($attributes, $searchTerm) {
                foreach (Arr::wrap($attributes) as $attribute) {
                    $query->when(
                        str_contains($attribute, '.'),
                        function (Builder $query) use ($attribute, $searchTerm) {
                            $data = explode('.', $attribute);
//                            [$relationName, $relationAttribute] = explode('.', $attribute);
                            $relationName = $data[0];
                            $relationAttribute = $data[1];

                            $query->orWhereHas($relationName, function (Builder $query) use ($relationAttribute, $searchTerm) {
                                $query->where($relationAttribute, 'LIKE', "%{$searchTerm}%");
                            });
                        },
                        function (Builder $query) use ($attribute, $searchTerm) {
                            $query->orWhere($attribute, 'LIKE', "%{$searchTerm}%");
                        }
                    );
                }
            });
            return $this;
        });

        Builder::macro('SortIn', function($sort_by, string $order) {
            if($sort_by==null)
                return $this;
            else if(str_contains($sort_by, '.')){

                $data = explode('.', $sort_by);
                $relationName = $data[0];
                $searchTerm = $data[1];

                $this->where(function (Builder $query) use ($relationName, $searchTerm, $order) {
                    $query->orWhereHas($relationName, function (Builder $query) use ($searchTerm, $order) {
                        $query->orderBy($searchTerm, ($order==null)?"asc":$order);
                    });
                });

            }else {
                    $this->orderBy($sort_by, ($order == null) ? "asc" : $order);
            }

            return $this;
        });




    }
}
