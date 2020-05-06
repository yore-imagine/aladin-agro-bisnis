<?php

namespace App\Http\Controllers;

use App\Attendance;
use Illuminate\Http\Request;
use DataTables;


class AttendanceController extends Controller
{
	public function index(Request $request)
    {        
		if ($request->ajax()) {
            $data = Attendance::orderBy('date', 'desc')->get();
            return Datatables::of($data)
                    ->addIndexColumn()
                    ->addColumn('action', function($row){ 
					   $btn = '<a href="'.route('attendance.show',['id' => $row->id]).'" class="m-r-15 text-dark" data-toggle="tooltip" data-placement="top" title="" data-original-title="Show"><i class="icofont icofont-eye"></i></a>';    					   
					   return $btn;
                    })
                    ->rawColumns(['action'])
                    ->make(true);
        }
      
        return view('attendances.index');
    }
	
	public function approval(Request $request)
    {        
		if ($request->ajax()) {
            $data = Attendance::with(['user','attendanceType'])->whereNull('approved_by')->orderBy('date', 'asc')->get();
            return Datatables::of($data)
                    ->addIndexColumn()				
                    ->addColumn('action', function($row){ 
					   $btn = '<a href="'.route('attendance.show',['id' => $row->id]).'" class="m-r-15 text-dark" data-toggle="tooltip" data-placement="top" title="" data-original-title="Show"><i class="icofont icofont-eye"></i></a>';    
					   $btn .= '<a href="#" class="m-r-15 text-info" data-toggle="tooltip" data-placement="top" title="" data-original-title="Approve"><i class="icofont icofont-check-circled"></i></a>';    
					   $btn .= '<a href="#" class="m-r-15 text-danger" data-toggle="tooltip" data-placement="top" title="" data-original-title="Reject"><i class="icofont icofont-close-circled"></i></a>';    
					   return $btn;
                    })
                    ->rawColumns(['action'])
                    ->make(true);
        }
      
        return view('attendances.approval');
    }
	
	public function history(Request $request)
    {        
		if ($request->ajax()) {
            $data = Attendance::with(['user','attendanceType'])->whereNotNull('approved_by')->orderBy('date', 'asc')->get();
            return Datatables::of($data)
                    ->addIndexColumn()
                    ->addColumn('action', function($row){ 
					   $btn = '<a href="'.route('attendance.show',['id' => $row->id]).'" class="m-r-15 text-dark" data-toggle="tooltip" data-placement="top" title="" data-original-title="Show"><i class="icofont icofont-eye"></i></a>';    					   
					   return $btn;
                    })
                    ->rawColumns(['action'])
                    ->make(true);
        }
      
        return view('attendances.history');
    }
	
	public function create()
    {
        return view('attendances.create');
    }
	
	public function store(Request $request)
    {
        //$request->validate([
        //    'name' => 'required',
        //    'detail' => 'required',
        //]);
  
        Attendance::create($request->all());
   
        return redirect()->route('attendances.index')->with('success','Attendance created successfully.');
    }
	
	public function show(Attendance $attendance)
    {
        return view('attendances.show',compact('attendance'));
    }
	
	public function edit(Attendance $attendance)
    {
        return view('attendances.edit',compact('attendance'));
    }
	
	public function update(Request $request, Attendance $attendance)
    {
        //$request->validate([
        //    'name' => 'required',
        //    'detail' => 'required',
        //]);
  
        $attendance->update($request->all());
  
        return redirect()->route('attendances.index')->with('success','Attendance updated successfully');
    }
	
	public function destroy(Attendance $attendance)
    {
        $attendance->delete();
  
        return redirect()->route('attendances.index')->with('success','Attendance deleted successfully');
    }
}