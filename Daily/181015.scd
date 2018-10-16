s.boot

(
SynthDef(\18101501,{
	arg freq = 100, decay = 0.5, noiseAmount = 0.3, amp = 0.75, out = 0;
	var sig, env, noiseEnv, freqEnv;
	env = XLine.kr(1, 0.001, decay, doneAction: 2);
	freqEnv = XLine.kr(freq, freq/10, decay/1.1);
	noiseEnv = XLine.kr(1, 0.001, decay/4);
	sig = (SinOsc.ar(freqEnv, mul: env) + BrownNoise.ar(noiseEnv*noiseAmount))* amp;
	Out.ar(out, sig!2)
}).add
)

~bd1 = Synth(\18101501)

(
SynthDef(\18101502,{
	arg freq = 500, decay = 0.5, noiseAmount = 0.9, amp = 0.75, out = 0, clickAmount = 1;
	var sig, env, noiseEnv, freqEnv, clickEnv;
	env = XLine.kr(1, 0.001, decay, doneAction: 2);
	noiseEnv = XLine.kr(1, 0.001, decay);
	//freqEnv = Line.kr(freq, freq/1.2, decay);
	clickEnv = XLine.kr(clickAmount, 0.001, 0.05);
	sig = amp * (SinOsc.ar(freq, mul: env*0.5) + PinkNoise.ar(noiseEnv*noiseAmount) + Blip.ar(freq*2, 4, clickEnv));
	Out.ar(out, sig!2)
}).add
)

~snd1 = Synth(\18101502)

(
SynthDef(\18101503,{
	arg freq = 2000, decay = 0.1, amp = 0.5, curve = -5, out = 0;
	var sig, env, clickEnv;
	env = EnvGen.kr(Env.perc(0.00001, decay, curve: curve),doneAction: 2);
	clickEnv = EnvGen.kr(Env.perc(0.0001, 0.001));
	sig = (GrayNoise.ar(env) + LFPulse.ar(freq, 0, 0.1, clickEnv)) * amp;
	Out.ar(out, sig!2)
}).add
)

~hh1 = Synth(\18101503)

(
SynthDef(\18101504,{
	arg freq = 740, decay = 0.25, amp = 0.5, distort = 0.5, out = 0;
	var sig, env;
	env = EnvGen.kr(Env.perc(0.001, decay, 5, curve: 100), doneAction:2);
	sig = SinOsc.ar(freq, mul: env).clip(-1,1)*amp;
	Out.ar(out, sig!2)
}).add
)

~bEEP = Synth(\18101504)

(
SynthDef(\18101505,{
	arg freq = 100, freqRange = 10, decay = 1, amp = 0.7, pulseEnvAmp = 1, pulseEnvFreq = 10, pulseEnvWidth = 0.5,
	freqEnvFreq = 11, freqRound = 10, width = 0.5, out = 0;
	var sig, env, pulseEnv, freqEnv;
	//env = EnvGen.kr(Env.perc(0.0001, decay, curve: 5), doneAction: 2);
	pulseEnv = LFPulse.kr(pulseEnvFreq,0,pulseEnvWidth,add: (1 - pulseEnvAmp)).clip(0, 1);
	freqEnv = {LFNoise0.kr(freqEnvFreq, freq*freqRange, freq)
		.linlin(0, freq+freq*freqRange, 40, freq+freq*freqRange)
		.round(freqRound)};
	sig = Pulse.ar(freqEnv, width, pulseEnv /* *env */)* amp;
	Out.ar(out, sig!2)
}).add
)

~chipPerc = Synth(\18101505)
~chipPerc.free
























