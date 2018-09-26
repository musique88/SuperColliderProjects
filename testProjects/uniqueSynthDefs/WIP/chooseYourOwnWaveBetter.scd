(
SynthDef(\wChoseSaw,{
	arg freq = 440, amp = 0.75, gen = 0.5, envDur = 1;
	var sig, env;
	env = XLine.ar(1, 0.001,envDur);
	sig = [
		SinOsc.ar(freq, mul: (gen.linlin(0, 1/2, 1, 0))),
		LFTri.ar(freq, mul: (gen.linlin(0, 1/3, 0, 1) + gen.linlin(1/3, 2/3, 0, -1))),
		LFSaw.ar(freq, mul: (gen.linlin(1/3,2/3,0,1) + gen.linlin(2/3, 1, 0, -1))),
		Pulse.ar(freq, mul: (gen.linlin(2/3, 1, 0, 1))),
	];
	sig = Mix(sig);
	sig = sig * amp;
	Out.ar(0, sig!2)
}).add
)

(
d = Pbind(
	\type, \set,
	\id, x.nodeID,
	\args, #[\gen],
	\dur, 1/50,
	\gen, Pseq((0..100)++(100..1),inf).linlin(0,100,0,1)
).play
)

d.stop

x = Synth(\wChoseSaw)
x.set()
x.free



~scope = Stethoscope(s)