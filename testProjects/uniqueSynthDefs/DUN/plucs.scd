s.boot

t = TempoClock.default

(
SynthDef(\pluc,{
	arg midiNote = 50, sawGain = 0.75, sinGain = 0.5, volume = 1;
	var sig, ampEnv, sig2;
	ampEnv = XLine.kr(1, 0.01, 0.2, doneAction: 2);
	sig = Saw.ar(midiNote.midicps) * sawGain * ampEnv;
	sig = sig + (SinOsc.ar((midiNote - 12).midicps) * sinGain * ampEnv);
	sig = sig * volume;
	sig2 = LFTri.ar((midiNote + 24).midicps) * ampEnv * volume;
	Out.ar(0, [sig, sig2])
}).add
)

x = Synth(\pluc)



(
Pdef(\plucPattern,
	(Pbind(
		\instrument, \pluc,
		\dur, 0.5,
		\volume, 0.5,
		\midiNote, Pseq([60,61, 67, 69, 72, 58], inf)

	))
).quant(1)
)

Pdef(\plucPattern).play;
Pdef(\plucPattern).stop