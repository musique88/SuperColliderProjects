s.boot
s.scope
s.quit

(
SynthDef(\chips2, {
	arg freq = 440, width = 0.5, pulseAmp = 1, release = 0.3, decay = 0.0001;
	var sig, ampEnv;
	ampEnv = XLine.kr(1, decay, release, doneAction: 2);
	sig = Pulse.ar(freq, width, ampEnv) * pulseAmp;
	Out.ar(0, sig!2);
	}
).add
)

x = Synth(\chips2)

(
Pdef(\chips2Def,
	Pbind(
		\instrument, \chips2,
		\dur, 1/8,
		\pulseAmp, 0.3,
		\release, 1/20,
		\decay, 0.1,
		\midinote, Prand([[50,50.5,50.2],[55.1, 55.2, 55]],inf)

	)
).play.quant(1)
)

Pdef(\chips2Def).stop

x.free