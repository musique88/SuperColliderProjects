s.boot;
s.scope;

(
SynthDef(\sicBass, {
	arg freq = 220, sineAmp = 0.5;
	var sig;
	sig = SinOsc.ar(freq/2) * sineAmp;
	Out.ar(0, sig!2)
}).add
)

~sicBass = Synth(\sicBass)