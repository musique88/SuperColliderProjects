s.boot

(
SynthDef(\chips, {
	arg width = 0.5, ampEnvFreq = 5, ampEnvWidth = 0.5, gain = 0.75,
	freqEnvFreq = 10, fund = 40, exp = 10, freqEnvFreqEnvFreq = 10;
	var sig, freqEnv, ampEnv, freqEnvFreqEnv;
	freqEnvFreqEnv = LFSaw.kr(freqEnvFreqEnvFreq, 0, 0.5, 0.5);
	ampEnv = LFPulse.kr(ampEnvFreq, 0, ampEnvWidth);
	freqEnv = LFNoise0.kr(freqEnvFreq).exprange(fund, fund * exp).round(fund) * freqEnvFreqEnv;
	sig = Pulse.ar(freqEnv, width, ampEnv) * gain;
	Out.ar(0, sig!2)
}).add
)

x = Synth(\chips)
x.set(\freqEnvFreq, 10)
x.set(\ampEnvFreq, 10)
x.set(\width, 0.5)
x.set(\ampEnvWidth, 1)
x.set(\gain, 0.4)
x.set(\fund, 50)
x.set(\exp, 10)
x.free