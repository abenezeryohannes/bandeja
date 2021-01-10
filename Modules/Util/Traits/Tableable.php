<?php


namespace Modules\Util\Traits;


use Illuminate\Http\Request;

trait Tableable
{


    public function index(Request $request)
    {
        $current_page = 1;
        $per_page = 10;
        if ($request->page) {
            $current_page = $request->page;
        }
        if ($request->per_page) {
            $per_page = $request->per_page;
        }
        if ($request->search) {
            $d = $this->search_item($request->search);
        }else{
            $d = $this->toTable();
        }
        $d = $d->map(function($dd){
            if(isset($dd->meta)){
                $dz = collect($dd)->merge($dd->meta);
                return $dz;
            }else{
                return $dd;
            }
        });

        $data = $d->forPage($current_page, $per_page);
        $total = $d->count();
        $from = ($current_page-1)*$per_page + 1;
        $to = $from + $per_page -1;
        if ($total<$to) {
            $to = $total;
        }
        if ($total<$from) {
            $from = $total;
        }
        $last_page = $total/$per_page;
        if ( floor($last_page)*$per_page != $total) {
            $last_page = floor($total/$per_page) + 1;
        }
        $page_links = collect([]);

        for($i=$current_page-3;$i<$current_page+3;$i++){
            if ($i>0 && $i<= $last_page) {
                $page_links->push($i);
            }
        }
        return response()->json(compact('current_page', 'page_links', 'per_page', 'total', 'from', 'to', 'last_page' , 'data'));
    }

}