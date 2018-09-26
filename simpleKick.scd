s.boot
s.scope
(
SynthDef(\kick,{
	arg noiseAmp = 0.5, noiseDur = 0.1, sineAmpRelease = 0.35,
	sineFreqRelease = 0.30, gain = 0.75, sineFreqStart = 100,
	sineFreqEnd = 10, noiseFreq = 1000;

	var sig, freqEnv, ampEnv, noiseEnvAmp;
	freqEnv = XLine.kr(sineFreqStart, sineFreqEnd, sineFreqRelease);
	ampEnv = XLine.kr(1, 0.001, sineAmpRelease, doneAction: 2);
	noiseEnvAmp = XLine.kr(1, 0.001, noiseDur) * noiseAmp;
	sig = SinOsc.ar(freqEnv)* ampEnv;
	sig = sig + {PinkNoise.ar(noiseEnvAmp)};
	sig = sig * gain;
	Out.ar(0, sig!2)
}).add
)

x = Synth(\kick)

(
Pdef(\kickPattern,
	Pbind(
		\instrument, \kick,
		\dur, 1/2,
		\gain, 1,
		\sineFreqStart, 100,
		\sineFreqEnd, 10,
		\noiseDur, 0.1
)).quant(1)
)

Pdef(\kickPattern).play
Pdef(\kickPattern).stop
