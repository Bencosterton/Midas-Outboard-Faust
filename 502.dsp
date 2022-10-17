import ("stdfaust.lib");

process = vgroup("midas 502", *(input) : fi.lowpass (2,lowpass) *(input) : fi.highpass (2,highpass) : *(output));

// Input knob
input = vslider("input [style:knob]", 14, 0, +60, 0.1) : ba.db2linear : si.smoo;

//low pass filter
lowpass=vslider("low pass [unit:Hz] [style:knob]",10000,100,15000,10) : si.smoo;

// high pass filter
highpass=vslider("high pass [unit:Hz] [style:knob]",150,10,400,10) : si.smoo;

// Output knob
output = vslider("trim output[style:knob]", -8, -20, +20, 0.1) : ba.db2linear : si.smoo;
