s.boot
s.scope

(
SynthDef(\mzonoSynth, {
	arg wave = 1, freq = 440, amp = 1;
	var	sig;
	sig = if(wave == 0){
		SinOsc.ar(freq) * amp;
	};
	if(wave == 1){
		Saw.ar(freq) * amp;
	};
	if(wave == 2){
		LFTri.ar(freq) * amp;
	};
	if(wave == 3){
		Pulse.ar(freq) * amp;
	};
	Out.ar(0, sig!2)
}).add
)