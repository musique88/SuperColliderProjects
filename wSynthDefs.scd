//List of Fun SynthDefs that I made all by myself

(
SynthDef(\wKick,{
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


