<?php

namespace Modules\Properties\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Validator;
use \Modules\Properties\Transformers\Index\Block as BlockIndexResource;
use \Modules\Properties\Transformers\Show\Block as BlockShowResource;
use \Modules\Properties\Entities\Block ;
use \Modules\Properties\Transformers\ResponseWrapper;
use \Modules\properties\Jobs\block\CreateBlock;
use \Modules\properties\Jobs\block\UpdateBlock;
use \Modules\properties\Jobs\block\DeleteBlock;

class BlocksController extends Controller
{
    public $perpage = 20;
    /**
     * Display a listing of the resource.
     * @return Renderable
     */
    public function index(Request $request)
    {
        $blocks = Block::simplepaginate($this->perpage);
        return BlockIndexResource::Collection($blocks);
    }

    /**
     * Show the form for creating a new resource.
     * @return Renderable
     */
    public function create()
    {
        return view('properties::create');
    }

    /**
     * Store a newly created resource in storage.
     * @param Request $request
     * @return Renderable
     */
    public function store(Request $request)
    {
        //validating the input fields
         $validator = Validator::make($request->all(), [
            'name' => 'bail|required|string',
            'site_id' => 'bail|required',
        ]);

        //returning the error if input is not correct
        if ($validator->fails()) {
            return response()->json([
                "status" => "error", 
                "message" => $validator->errors()->first("name") . $validator->errors()->first("site_id")
            ]);
        }

        //save to database and return the response
        $response = CreateBlock::dispatchNow($request);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, 'Block');
    }

    /**
     * Show the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function show($id)
    {
        $block = Block::find($id);
        if($block==null)$block = "No block found with this id";
        return ResponseWrapper::WrapSuccess($block, 'showBlock');
    }

    /**
     * Show the form for editing the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function edit($id)
    {
        return view('properties::edit');
    }

    /** 
     * Update the specified resource in storage.
     * @param Request $request
     * @param int $id
     * @return Renderable
     */
    public function update(Request $request, $id)
    {
        //validating the input fields
        $validator = Validator::make($request->all(), [
            'name' => 'bail|required|string',
            'site_id' => 'bail|required',
        ]);

        //returning the error if input is not correct
        if ($validator->fails()) {
            return response()->json([
                "status" => "error", 
                "message" => $validator->errors()->first("name") . $validator->errors()->first("site_id")
            ]);
        }

     
        //save to database and return the response
        $response = UpdateBlock::dispatchNow($request, $id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, 'Property');
    }

    /**
     * Remove the specified resource from storage.
     * @param int $id
     * @return Renderable
     */
    public function destroy($id)
    {
            
        //save to database and return the response
        $response = DeleteBlock::dispatchNow($id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, 'Nothing'); 
    }
}
