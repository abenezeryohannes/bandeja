<?php

namespace Modules\Accounts\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Validator;
use Modules\Accounts\Entities\Category;
use Modules\Accounts\Jobs\Category\CreateCategory;
use Modules\Accounts\Jobs\Category\DeleteCategory;
use Modules\Accounts\Jobs\Category\UpdateCategory;
use Modules\Accounts\Transformers\ResponseWrapper;

class CategoriesController extends Controller
{

    public $perpage = 20;

    public function index()
    {
        $category = Category::simplepaginate($this->perpage);
        return \Modules\Accounts\Transformers\Mini\Category::Collection($category);
    }


    public function create()
    {
        return view('accounts::create');
    }

    public function store(Request $request)
    {
        //validating the input fields
        $request->validate([
            'name' => 'bail|required|string',
            'type' => 'bail|required|string',
        ]);


        //save to database and return the response
        $response = CreateCategory::dispatchNow($request);
        return ResponseWrapper::WrapSuccess($response, 'CategoryMini');
    }


    public function show($id)
    {
        $category = Category::find($id);
        if($category==null)$category = "No category found with this id";
        return new \Modules\Accounts\Transformers\Mini\Category($category);
    }


     public function edit($id)
    {
        return view('accounts::edit');
    }


    public function update(Request $request, $id)
    {

        //save to database and return the response
        $response = UpdateCategory::dispatchNow($request, $id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, 'CategoryMini');

    }


    public function destroy($id)
    {
        //save to database and return the response
        $response = DeleteCategory::dispatchNow($id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, null);
    }
}
