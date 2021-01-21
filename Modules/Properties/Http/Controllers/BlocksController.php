<?php

namespace Modules\Properties\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Validator;
use Modules\Properties\Jobs\Block\SearchAndSortBlock;
use \Modules\Properties\Transformers\Index\Block as BlockIndexResource;
use Modules\Properties\Transformers\Index\Property as PropertyIndexResource;
use \Modules\Properties\Transformers\Show\Block as BlockShowResource;
use \Modules\Properties\Entities\Block ;
use \Modules\Properties\Transformers\ResponseWrapper;
use \Modules\Properties\Jobs\Block\CreateBlock;
use \Modules\Properties\Jobs\Block\UpdateBlock;
use \Modules\Properties\Jobs\Block\DeleteBlock;

class BlocksController extends Controller
{
    public $perpage = 20;

    public function index(Request $request)
    {
        $blocks = SearchAndSortBlock::dispatchNow($request['search'],$request['sort_by'],$request['order']);
        return BlockIndexResource::Collection($blocks);
    }

    public function create()
    {
        $form = new \Modules\Properties\UI\Forms\BlocksForm('create');
        return response()->json($form->generate());
    }


    public function store(Request $request)
    {
        //validating the input fields
        $request->validate([
            'name' => 'required|string',
            'site_id' => 'required',
            'properties' => 'required',
        ]);

        //save to database and return the response
        $response = CreateBlock::dispatchNow($request);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, 'Block');
    }


    public function show($id)
    {
        $block = Block::find($id);
        if($block==null)$block = "No block found with this id";
        return ResponseWrapper::WrapSuccess($block, 'showBlock');
    }


    public function edit($id)
    {
        return view('properties::edit');
    }


    public function update(Request $request, $id)
    {

        //save to database and return the response
        $response = UpdateBlock::dispatchNow($request, $id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, 'Property');
    }


    public function destroy($id)
    {
            
        //save to database and return the response
        $response = DeleteBlock::dispatchNow($id);

        //$response returns the data inserted into the database
        return ResponseWrapper::WrapSuccess($response, 'Nothing'); 
    }


    public function destroyAll(Request $request)
    {
        $request->validate(['ids'=>'required']);

        $ids = explode(',', $request['ids']);

        foreach ($ids as $id){
            $response = DeleteBlock::dispatchNow($id);
        }

        return ResponseWrapper::WrapSuccess($response, 'Nothing');
    }
}
