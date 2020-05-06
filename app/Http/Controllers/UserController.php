<?php

namespace App\Http\Controllers;

use App\User;
use Illuminate\Http\Request;
use DataTables;


class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        if ($request->ajax()) {
            $data = User::with(['role','timezone','creator','editor'])->orderBy('created_at', 'desc')->get();
            return Datatables::of($data)
                    ->addIndexColumn()					
                    ->addColumn('action', function($row){ 
					   $btn = '<a href="'.route('user.show',$row->nrp).'" class="m-r-15 text-dark" data-toggle="tooltip" data-placement="top" title="" data-original-title="Show"><i class="icofont icofont-eye"></i></a>';    					   
					   $btn .= '<a href="'.route('user.edit',$row->nrp).'" class="m-r-15 text-info" data-toggle="tooltip" data-placement="top" title="" data-original-title="Edit"><i class="icofont icofont-edit"></i></a>';    					   
					   $btn .= '<a href="#" class="m-r-15 text-danger" data-toggle="tooltip" data-placement="top" title="" data-original-title="Delete"><i class="icofont icofont-trash"></i></a>';    					   
					   return $btn;
                    })
                    ->rawColumns(['action'])
                    ->make(true);
        }
      
        return view('users.index');
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
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
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
        //
    }
}
