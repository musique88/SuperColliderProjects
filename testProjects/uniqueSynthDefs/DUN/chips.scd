s.boot;
s.quit;

(
SynthDef(\chips,{
	arg fund = 40, exp = 10, ampEnvFreq = 10, ampEnvWidth = 0.5, ampEnvAmp = 1,
	width = 0.5, freqNoise = 20;
	var sig, freqEnv, ampEnv;
	freqEnv = LFNoise0.kr(freqNoise).exprange(fund, fund * exp).round(fund);
	ampEnv = LFPulse.kr(ampEnvFreq, 0, ampEnvWidth) * ampEnvAmp;
	sig = Pulse.ar(freqEnv, width, ampEnv);
	Out.ar(0, sig!2);
}).add
)

x = Synth(\chips)
x.set(\ampEnvFreq, 10)
x.set(\freqNoise, 0.005)
x.set(\ampEnvWidth, 0.5)
x.set(\fund, 40)
x.set(\exp, 15)
x.set(\width, 0.5)
x.free