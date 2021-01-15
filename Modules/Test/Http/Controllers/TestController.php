<?php

namespace Modules\Test\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Modules\Test\Entities\Test as TestModel;
use Illuminate\Support\Facades\Storage;

class TestController extends Controller
{

	public function __construct()
	{
		$this->middleware('auth');
		// $this->middleware('role:teacher');
		$this->middleware('permission:FINANCE.INDEX');
	}

    public function media(Request $request)
    {
        $request->validate([
            'picture' => 'file|required'
        ]);
        $t = new TestModel();
        $t->title = $request['name'];
        // $s = Storage::put('public/b/c/nice', $request->file('picture'));
        // return [$s];
        $t->media = $request->picture;
        // $t->media = "popo";
        $t->save();
        return $request->all();   
    }

    public function plan()
    {
        $t = "public/b/c/nice/fz2TSGB0RDSTLU46NwPBYCZYzyWm1TKUquSkGOah.jpg";
        // $url = Storage::url($t);
        // return [asset($t), route('media',['path'=> $t])];

        // $t = TestModel::query();
        // $t->delete();

        // dd(app('authorization'));
        // $t = TestModel::create([
        //     'title' => 'real2',
        //     'media_data' => ['jjj']
        // ]);
        // $m = TestModel::first();

        // dd($m->remove_media('dd'));
        return response()->json([
        	'tests' => TestModel::all()
        ]);
        // return response()->json([
        // ], 401);
    }
}
