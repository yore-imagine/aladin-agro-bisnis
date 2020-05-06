<?php

namespace App\Http\Controllers;

use App\Timezone;
use Illuminate\Http\Request;
use DataTables;

class TimezoneController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        if ($request->ajax()) {
            $data = Timezone::with(['creator','editor'])->orderBy('created_at', 'desc')->get();
            return Datatables::of($data)
                    ->addIndexColumn()					
                    ->addColumn('action', function($row){ 
					   $btn = '<a href="#" class="m-r-15 text-dark md-trigger" data-toggle="tooltip" data-placement="top" title="" data-original-title="Show" data-modal="modal-timezone" data-id="'.$row->id.'" data-action="show"><i class="icofont icofont-eye"></i></a>';    					   
					   $btn .= '<a href="#" class="m-r-15 text-info md-trigger" data-toggle="tooltip" data-placement="top" title="" data-original-title="Edit" data-modal="modal-timezone" data-id="'.$row->id.'" data-action="edit"><i class="icofont icofont-edit"></i></a>';    					   
					   $btn .= '<a href="#" class="m-r-15 text-danger md-trigger" data-toggle="tooltip" data-placement="top" title="" data-original-title="Delete" data-original-title="Edit" data-modal="modal-timezone" data-id="'.$row->id.'" data-action="delete"><i class="icofont icofont-trash"></i></a>';    					   					   
					   return $btn;
                    })
                    ->rawColumns(['action'])
                    ->make(true);
        }
      
        return view('timezones.index');
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $this->validate($request, [
		  'id'=>'required',
		  'description'=>'required',
		  'code'=>'required',
		  'status'=>'required',
		]);	
	
		$exist = Timezone::find($request->id);
		$updated = ($exist != null ? \Auth::user()->nrp : null);		
		Timezone::updateOrCreate(['id' => $request->id],
                ['description' => $request->description,'code' => $request->code, 'status' => $request->status, 'created_by' => \Auth::user()->nrp, 'updated_by' => $updated]); 
   
        return response()->json(['success'=>'Timezone Type saved successfully.']);		
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show(Request $request, $id)
    {
        $item = Timezone::find($id);
		if ($request->ajax()) {
			return response()->json($item);
		}
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        Timezone::find($id)->delete();     
       return response()->json(['success'=>'Timezone Type deleted successfully.']);
    }
}
